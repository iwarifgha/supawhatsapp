import 'package:supabase_flutter/supabase_flutter.dart';


class MyUser {
  final String imageUrl;
  final String phoneNumber;
  final String name;
  final String id;

  MyUser({
    required this.imageUrl,
    required this.phoneNumber,
    required this.id,
    required this.name
  });

  factory MyUser.fromSupabaseAuth(User user){
    return MyUser(
        phoneNumber: user.phone!,
        id: user.id,
        imageUrl: '',
        name: ''
    );
  }

  MyUser.fromDatabase(Map<String, dynamic> value):
        name = value['name'],
        id = value['id'],
        imageUrl = value['image_url'],
        phoneNumber = value['phone'];

}