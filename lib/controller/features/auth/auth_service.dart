import 'dart:async';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatsapp_clone/controller/features/auth/auth_interface.dart';
import 'package:whatsapp_clone/helpers/utils/password_generator.dart';
import '../../../model/user/user.dart';
import '../../../supabase.dart';


class AuthService extends AuthProvider{
  AuthService();


///Gets the currently logged in user
@override
  MyUser? get currentUser {
  final user = MySupabaseClient.supabase.auth.currentUser;
  if(user != null){
    print('user is not null');
    return MyUser.fromSupabaseAuth(user);
  }
  return null;
}

///Signs in the user
@override
  Future<void> signIn({
  required String phoneNumber
}) async {
  await MySupabaseClient.supabase.auth.
  signInWithOtp(
      phone: phoneNumber
  );
}



///Sign out
@override
  Future<void> signOut() async {
  await MySupabaseClient.supabase.auth.signOut();
}


///Verifies token sent to user
@override
  Future<MyUser?> verifyNumber({
  required String phoneNumber,
  required String token}) async {
  try {
    final response = await MySupabaseClient.supabase.auth.verifyOTP(
        token: token,
        type: OtpType.sms,
        phone: phoneNumber
    );
    if(response.user == null) return null;
    final phone = response.user!.phone!;
    return MyUser(
        phoneNumber: phone ,
        id: response.user!.id,
        imageUrl: '',
        name: phone.toString()
    );
  } on Exception catch (e) {
    throw Exception(e);
  }
}
  ///Registers a user. Supabase requires a password to create a
  ///user. However, this is not needed for this App as it uses phone sign-in.
  ///So we generate a random password.
@override
  Future<MyUser> signUp({
  required String phoneNumber,
}) async {
  try {
    final user = await MySupabaseClient.supabase.auth.signUp(
        password: generatePassword(),
        phone: phoneNumber
    );
    return MyUser.fromSupabaseAuth(user.user!);
  } on Exception catch (e) {
    throw Exception(e);
  }
}

  @override
  Stream<AuthState> get currentState => MySupabaseClient.supabase.auth.onAuthStateChange;
}






















//'-=£%£21¬/6^&*(0)()_=-=£%£21¬/6^&*(0)()',
/* Future<MyUser> signUpWithPassword({
    required String phoneNumber,
    required String password
  }) async {
    try {
      final user = await MySupabaseClient.supabase.auth.signUp(
          password: password,
          phone: phoneNumber
      );
      return MyUser.fromSupabaseAuth(user.user!);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }*/
/*@override
  Future<void> signInWithPassword({
    required String phoneNumber,
    required String password,

  }) async {
    await MySupabaseClient.supabase.auth.signInWithPassword(
        phone: phoneNumber,
        password: password
    );
  }*/
