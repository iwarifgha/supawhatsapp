import 'package:supabase_flutter/supabase_flutter.dart';

import 'message_model.dart';

class AppUser{
  final String? userImage;
  final String? name;
  final String number;
  final List<AppMessage>? messages;

  AppUser({ this.userImage,  this.name, required this.number, this.messages});


  factory AppUser.fromSupabase(User user){
    return AppUser(number: user.phone!);
  }

  @override
  bool operator ==(Object other) {
     return (other is AppUser) && other.number == number;
  }


}