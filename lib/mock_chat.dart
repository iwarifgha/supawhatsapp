

import 'package:whatsapp_clone/user_model.dart';

import 'chat_model.dart';
 import 'message_model.dart';

List<AppChat> mockChat = <AppChat>[
  AppChat(
      chatOwner:   AppUser(userImage: 'assets/beach-umbrella.png' , name:  'James', number: '574680432'),
      messages: [
        AppMessage(
            sender: AppUser(userImage: 'assets/beach-umbrella.png' , name:  'James', number: '574680432'),
            message: 'Guy, you dey come the program? Holla me asap'
        ),
])]
 ;