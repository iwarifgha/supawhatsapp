


import '../../../model/user/user.dart';
import '../../../model/user/user_session.dart';

abstract class AuthProvider{
   MyUser? get currentUser;

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