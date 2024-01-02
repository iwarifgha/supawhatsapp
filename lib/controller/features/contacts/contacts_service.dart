import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp_clone/helpers/utils/locator.dart';
import 'package:whatsapp_clone/helpers/utils/sqlite.dart';
import '../../../helpers/utils/constants.dart';
import '../../../model/contact/contact.dart';
import '../../../supabase_client.dart';



class ContactService {




  final supabase = MySupabaseClient.supabase;
  final localDb = MyLocalStorage();




  Future<List<MyContact>> autoAddContact() async {
    final db = await localDb.getDatabase;
    final appContacts = await _getAllContactsFromLocalStorage();
    final phoneBookContacts = await _getContactsFromPhoneBook();
    final whatsappUsers = await _getAllUsers();
    for(var contact in phoneBookContacts){
      if (!appContacts.contains(contact) ) {
        await db.insert(contactsTable, {
          idField: contact.localId,
          nameField: contact.name,
          phoneField: contact.phoneNumber,
          isWhatsappUser: 0
        });
      }
      if(whatsappUsers.contains(contact)){
        await db.update(contactsTable, {
          isWhatsappUser: 1,
          aboutField: whatsappUsers.first.about
        },
        where: '$idField = ?',
          whereArgs: [contact.localId]
        );
      }
    }
    final contacts = await getWhatsappContacts();
    return contacts;
   }

  Future<List<MyContact>> _getAllUsers() async {
    final response = await supabase.
    from(usersTableSupabase).
    select('*') as List<dynamic>;
    final list = response.map((e) => MyContact.fromSupabase(e)).toList();
    return list;
  }


  Future<List<MyContact>> _getContactsFromPhoneBook() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
     if(permissionGranted){
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      contacts.removeWhere((element) => element.phones.isEmpty);
      final convertedContacts = contacts.map((e) => MyContact.fromPhoneBook(e)).toList();
      return convertedContacts;
    }
    else {
      return [];
    }
  }
  Future<List<MyContact>> getContacts() async {
    final db = await localDb.getDatabase;
    final response = await db.query(contactsTable);
    return response.map((e) => MyContact.fromLocalDatabase(e)).toList();
  }

  Future<List<MyContact>> getWhatsappContacts() async {
     final db = await localDb.getDatabase;
     final response =  await db.transaction((txn) {
         final y = txn.query(
         contactsTable,
         where: '$isWhatsappUser=?',
         whereArgs: [1]
     );
         return y;
     });

     final contacts = response.map((item) => MyContact.fromLocalDatabase(item)).toList();
     return contacts;
  }

  ///read a contact from the local database
  Future<MyContact> getContact(String phone) async {
    final db = await localDb.getDatabase;
    final result = await db.query(
        contactsTable,
        limit: 1,
        where: '$phoneField = ?',
        whereArgs: [phone]);
    print(result);
    final contact = MyContact.fromLocalDatabase(result.first);
    return contact;
  }

//----------------------------------------------------------------------------

  Future<void> addContactsToLocalStorage() async {
    final db = await localDb.getDatabase;
    final phoneContacts = await _getContactsFromUserPhoneBook();
    final whatsappContacts = await _getAllContactsFromLocalStorage();
    for(var pContact in phoneContacts){
      final newList = whatsappContacts.where((wContact) => wContact.phoneNumber != pContact.phones.first.number  );

      if(newList.isNotEmpty){
        for (var item in newList) {
          await db.insert(contactsTable, {
            idField: item.userId,
            nameField: item.name,
            phoneField: item.phoneNumber,
          });
        }
        print('new contacts were added');
      }
    }
  }

  Future<List<MyContact>> contactsOnWhatsapp() async {
    final userContacts = await _getAllContactsFromLocalStorage();
    final whatsappUsers = await _getAllUsers();
     List<MyContact> contactList = [];
    for(var user in whatsappUsers){
      final newList = userContacts.where((contact) => contact.phoneNumber == user.phoneNumber);
      newList.map((e) => contactList.add(e));
    }
    return contactList;
  }

  Future<List<MyContact>> contactsNotOnWhatsapp() async {
    final userContacts = await _getAllContactsFromLocalStorage();
    final whatsappUsers = await _getAllUsers();
    List<MyContact> contactList = [];
    for(var user in whatsappUsers){
      final newList = userContacts.where((contact) => contact.phoneNumber != user.phoneNumber);
      newList.map((e) => contactList.add(e));
    }
    return contactList;
  }


  Future<List<MyContact>> _getAllContactsFromLocalStorage() async {
    final db = await localDb.getDatabase;
    final result = await db.query(contactsTable);
    final contacts = result.map((e) => MyContact.fromSupabase(e)).toList();
    return contacts;
  }




  Future<MyContact> _getAContactWithLocalId(int id) async {
    final db = await localDb.getDatabase;
    final result = await db.query(
        contactsTable,
        limit: 1,
        where: 'sql_id = ?',
        whereArgs: [id]);
    print(result);
    final data = MyContact.fromSupabase(result.first);
    return data;
  }





  Future<List<Contact>> _getContactsFromUserPhoneBook() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    List<Contact> emptyContacts = [];
    if(permissionGranted){
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      contacts.removeWhere((element) => element.phones.isEmpty);
       return contacts;
    }
    else {
      return emptyContacts;
    }
  }



}