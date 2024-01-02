import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatsapp_clone/controller/features/auth/auth_interface.dart';
import '../../../helpers/exceptions/exceptions.dart';
import '../../../helpers/utils/locator.dart';

import '../../../model/user/user.dart';
import '../../../supabase_client.dart';
import '../user/user_service.dart';

class AuthService extends AuthProvider{
  AuthService();


///gets currently logged in user
@override
  MyUser? get currentUser {
  final user = MySupabaseClient.supabase.auth.currentSession?.user;
  if(user != null){
    return MyUser.fromSupabaseAuth(user);
  }
  return null;
}

///Signs in the user
@override
  Future<void> signIn({
  required String phoneNumber
}) async {
  await MySupabaseClient.supabase.auth.signInWithOtp(phone: phoneNumber);
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
  ///So a random password is generated.
@override
  Future<MyUser> signUp({
  required String phoneNumber
}) async {
  try {
    final user = await MySupabaseClient.supabase.auth.signUp(
        password: '-=£%£21¬/6^&*(0)()_=-=£%£21¬/6^&*(0)()',//not secure
        phone: phoneNumber
    );
    return MyUser.fromSupabaseAuth(user.user!);
  } on Exception catch (e) {
    throw Exception(e);
  }
}


}