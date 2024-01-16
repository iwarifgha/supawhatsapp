import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../model/contact/contact.dart';



class ContactService {

  Future<List<MyContact>> getContacts() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    if (permissionGranted) {
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      contacts.removeWhere((contact) => contact.phones.isEmpty);
      final userContacts = contacts.map((e) => MyContact.fromPhoneBook(e));
      return userContacts.toList();
       } else {
         throw Exception('Requires permission');
       }

  }


  }