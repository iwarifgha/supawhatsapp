import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/model/user/user.dart';

import '../../../model/contact/contact.dart';

abstract class ContactCubitState extends Equatable {
  final bool? hasException;
  final bool? isLoading;
  final String? errorMessage;


  const ContactCubitState({
    this.hasException,
    this.isLoading,
    this.errorMessage});
}

class ContactListState extends ContactCubitState {
   final List<MyContact> contacts;
   final MyUser currentUser;

   const ContactListState({
    required this.contacts,
    required this.currentUser,
    super.isLoading,
    super.hasException,
    super.errorMessage
  });


  @override
  List<Object?> get props => [isLoading, hasException, errorMessage, contacts];

}

class ContactSelectedState extends ContactCubitState {
  final MyUser currentUser;
  final MyUser contact;

  const ContactSelectedState({
    required this.contact,
    required this.currentUser
  });
  @override
  List<Object?> get props => [currentUser];
}

class ContactInitialState extends ContactCubitState {
  const ContactInitialState();
  @override
  List<Object?> get props => [];
}