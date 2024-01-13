import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../model/contact/contact.dart';
import '../../../supabase.dart';



class ContactService {

  final supabase = MySupabaseClient.supabase;


  /*Future<List<MyContact>> contactsOnWhatsapp() async {
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

  Future<List<MyContact>> _getAllUsers() async {
    final response = await supabase.
    from(usersTableSupabase).
    select('*') as List<dynamic>;
    final list = response.map((e) => MyContact.fromSupabase(e)).toList();
    return list;
  }
*/
  Future<List<MyContact>> getContacts() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    if (permissionGranted) {
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      final userContacts = contacts.map((e) => MyContact.fromPhoneBook(e));
      return userContacts.toList();
       } else {
         throw Exception('Requires permission');
       }

  }


  }