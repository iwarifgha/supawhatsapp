import 'package:equatable/equatable.dart';

import '../../../model/contact/contact.dart';

abstract class ContactCubitState extends Equatable {
  const ContactCubitState();
}

class ContactListState extends ContactCubitState {
  final bool? hasException;
  final bool? isLoading;
  final String? errorMessage;
  final List<MyContact> contacts;


  const ContactListState({
    required this.contacts,
    this.isLoading,
    this.hasException,
    this.errorMessage
  });

  @override
  List<Object?> get props => [isLoading, hasException, errorMessage, contacts];

}

class ContactSelectedState extends ContactCubitState {
  const ContactSelectedState();
  @override
  List<Object?> get props => [];
}

class ContactInitialState extends ContactCubitState {
  const ContactInitialState();
  @override
  List<Object?> get props => [];
}