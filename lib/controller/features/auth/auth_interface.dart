


import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../model/user/user.dart';

abstract class AuthProvider{
   MyUser? get currentUser;
   Stream<AuthState> get currentState;

  Future<void> signIn ({
    required String phoneNumber});

   Future<void> signUp ({
     required String phoneNumber});

   Future<MyUser?> verifyNumber({
    required String phoneNumber,
    required String token
});


  Future<void> signOut();
}