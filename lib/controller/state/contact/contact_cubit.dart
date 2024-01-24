import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/controller/features/contacts/contacts_service.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_state.dart';
import 'package:whatsapp_clone/model/user/user.dart';

import '../../../helpers/utils/locator.dart';
import '../../features/user/user_service.dart';

class ContactCubit extends Cubit<ContactCubitState> {
  final MyUser user;
  ContactCubit(this.user) : super(const ContactInitialState()){
    showContacts(user: user);
  }

  final userProvider = locator<UserService>();
  final contactProvider = locator<ContactService>();



  showContacts({
    required MyUser user
}) async {
    final contacts = await contactProvider.getContacts();
    emit(ContactListState(contacts: contacts, currentUser: user));
  }

  getAUser({
    required String phone,
    required MyUser currentUser
  }) async {
     emit(ContactListState(isLoading: true, contacts: const [], currentUser: currentUser));
    try {
      final isConnected = await InternetConnection().hasInternetAccess;
      if (isConnected) {
        final userContact = await userProvider.getUserFromSupabaseByPhone(phone);
        if (userContact == null) {
          throw Exception('User not found');
        }
        emit(ContactListState(isLoading: false, contacts: const [], currentUser: currentUser));
        emit(ContactSelectedState(currentUser: currentUser, contact: userContact));
      }
      else {
        throw Exception('No internet');
      }
    } on Exception catch (e) {
      final contacts = await contactProvider.getContacts();
      emit(ContactListState(
          hasException: true,
          isLoading:  false,
          errorMessage: e.toString(),
          contacts: contacts,
          currentUser: currentUser
      ));
    }
  }
}