 import 'package:whatsapp_clone/user_model.dart';

import 'message_model.dart';

class AppChat{
  final AppUser chatOwner;
  final List<AppMessage> messages;


  AppChat({ required this.chatOwner, required this.messages});
}