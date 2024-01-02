import 'package:get_it/get_it.dart';
import '../../controller/features/auth/auth_service.dart';
import '../../controller/features/chat/message_chat_service.dart';
import '../../controller/features/contacts/contacts_service.dart';
import '../../controller/features/storage/storage_service.dart';
import '../../controller/features/user/user_service.dart';

final locator = GetIt.instance;

///Initializes my registered repositories/services.
initLocator(){
  locator.registerSingleton(ContactService());
  //locator.registerSingleton((MyLocalStorage()));
  locator.registerSingleton(MessageChatService());
  locator.registerSingleton(StorageService());
  locator.registerSingleton(UserService());
  locator.registerSingleton(AuthService());



}
