import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/controller/features/contacts/contacts_service.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_state.dart';

import '../../../helpers/utils/locator.dart';
import '../../features/user/user_service.dart';

class ContactCubit extends Cubit<ContactCubitState> {
  ContactCubit() : super(const ContactInitialState()){
    showContacts();
  }

  final userProvider = locator<UserService>();
  final contactProvider = locator<ContactService>();


  showContacts() async {
    final contacts = await contactProvider.getContacts();
    emit(ContactListState(contacts: contacts));
  }

  getAUser({required String phone}) async {
    try {
      final isConnected = await InternetConnection().hasInternetAccess;
      if (isConnected) {
        final userContact = await userProvider.getUserFromSupabaseByPhone(phone);
        if (userContact == null) {
          throw Exception('User not found');
        }
        emit(const ContactSelectedState());
      }
      else {
        throw Exception('No internet');
      }
    } on Exception catch (e) {
      final contacts = await contactProvider.getContacts();
      emit(ContactListState(
          hasException: true,
          errorMessage: e.toString(),
          contacts: contacts
      ));
    }
  }
}