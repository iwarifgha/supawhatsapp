import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whatsapp_clone/helpers/utils/constants.dart';

class MyContact extends Equatable {
  final String? name;
  final String phoneNumber;
  final String? userId;
  final String? localId;
  final String? about;
  final String avatarUrl;

  const MyContact({
    this.about,
    this.localId,
    this.userId,
    required this.phoneNumber,
    this.name,
    this.avatarUrl = 'assets/avatar.png'
  });




  static MyContact fromPhoneBook(Contact value){
    return MyContact(
        localId: value.id,
        name: value.displayName,
        phoneNumber: value.phones.first.number,
     );
  }

  static MyContact fromSupabase(Map<String, dynamic> value){
    return MyContact(
        userId: value[idField],
        name: value[nameField],
        phoneNumber: value[phoneField],
        about: value[aboutField]
    );
  }
  static MyContact fromLocalDatabase(Map<String, dynamic> value){
    return MyContact(
        localId: value[idField],
        name: value[nameField],
        phoneNumber: value[phoneField],
     );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>  [phoneNumber];
}