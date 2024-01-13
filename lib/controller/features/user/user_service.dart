import 'dart:io';



import '../../../helpers/exceptions/exceptions.dart';
import '../../../helpers/utils/constants.dart';
import '../../../helpers/utils/locator.dart';
import '../../../model/user/user.dart';
import '../../../supabase.dart';
import '../storage/storage_service.dart';


//get user by id
//save user to local cache
//fetch user from local cache or from supabase


class UserService {
  final supabase = MySupabaseClient.supabase;
  final storageProvider = locator<StorageService>();




  ///Update the user data such as name and profile picture
  Future<MyUser> updateUserDataOnSupabase({
    required String id,
    required String name,
    required File avatar,
  }) async {
    final user = await getUserByIdFromSupabase(id);
    final profileImage = storageProvider.
    uploadFile(
        avatarFile: avatar,
        userId: user.id
    );
    final response = await supabase.from(usersTableSupabase).
    update({
      nameField: name,
      imageUrlField: profileImage
    }).eq(idField, user.id).
    select() as List<dynamic>;

    final newUser = response.map((e) => MyUser.fromDatabase(e)).toList().first;
    return newUser;
  }





  Future<MyUser> getUserByIdFromSupabase(String userId) async {
    final response = await supabase.from(usersTableSupabase)
        .select('phone')
        .eq('id', userId)
        .limit(1)
        .maybeSingle();
    if(response == null){
      throw UserNotFoundException();
    }
    final user = MyUser.fromDatabase(response.first);
    return user;
  }









  ///Fetch the user from supabase using their phone number
  Future<MyUser?> getUserFromSupabaseByPhone(String phone) async {
    final response = await supabase.from(usersTableSupabase)
        .select()
        .eq(phoneField, phone)
        .limit(1)
        .maybeSingle();

    if(response == null){
      return null;
    }
    final user = MyUser.fromDatabase(response.first);
    return user;

  }

  ///All users
  Future<Iterable<MyUser>> getAllUsersOnSupabase() async {
    final response = await supabase.
    from(usersTableSupabase).
    select<List<Map<String, dynamic>>>(phoneField);
    final user = response.map((e) => MyUser.fromDatabase(e));
    return user;
  }

}