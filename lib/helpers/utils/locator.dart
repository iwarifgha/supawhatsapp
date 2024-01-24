import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/helpers/utils/loading_overlay.dart';
import '../../controller/features/auth/auth_service.dart';
import '../../controller/features/chat/chat_service.dart';
import '../../controller/features/contacts/contacts_service.dart';
import '../../controller/features/storage/storage_service.dart';
import '../../controller/features/user/user_service.dart';

final locator = GetIt.instance;

///Initializes my registered repositories/services.
initLocator(){
  locator.registerSingleton(ContactService());
  locator.registerSingleton((AlertOverlay()));
  locator.registerSingleton(AuthService());
  locator.registerSingleton(MessageChatService());
  locator.registerSingleton(StorageService());
  locator.registerSingleton(UserService());



}
