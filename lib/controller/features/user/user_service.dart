import 'dart:io';



import '../../../helpers/exceptions/exceptions.dart';
import '../../../helpers/utils/constants.dart';
import '../../../helpers/utils/locator.dart';
import '../../../helpers/utils/sqlite.dart';
import '../../../model/user/user.dart';
import '../../../supabase_client.dart';
import '../storage/storage_service.dart';


//get user by id
//save user to local cache
//fetch user from local cache or from supabase


class UserService {
  final supabase = MySupabaseClient.supabase;
  final storageProvider = locator<StorageService>();


  final localDb = MyLocalStorage();


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


  ///Inserts or replace a user in the local database.
  ///When a user signs out, this user is deleted from the table.
  ///On signing in again the user is inserted again. If there is already a
  ///user with such credentials, it is replaced, ensuring that there is only one
  ///user in this table at every point in time.

  Future<MyUser> saveUser ({
    required String id,
    required String name,
    required String imageUrl,
    required String phone
})  async {
    final dB = await localDb.getDatabase;
    final userId = await dB.transaction((txn) =>
        txn.rawInsert('REPLACE INTO user (id, name, image_Url, phone) '
            'VALUES("$id", "$name", "$imageUrl", "$phone")')
    );
    final result = await dB.query(
        localUserTable,
        where: 'sql_id = ?',
        whereArgs: [userId] );
    final user = MyUser.fromDatabase(result.first);
    return user;
  }

  ///There can only be one user on the 'localUserTable'
  ///so no where argument is used to fetch its data.
  ///This is the user saved to the local database
  ///during sign-up or sign-in.
  Future<MyUser?> fetchUser() async {
    final dB = await localDb.getDatabase;
    final result = await dB.query(localUserTable);

    if(result.isEmpty){
      return null;
    }
    if(result.length > 1){
      throw Exception (
          'A fatal error occurred. '
          'Please re-install the app'
      );
    }
    final user = MyUser.fromDatabase(result.first);
    return user;
  }



  Future<MyUser?> getLocalUserWithID({
    required String id
  }) async {
    final dB = await localDb.getDatabase;
    final result = await dB.query(
        localUserTable,
        limit: 1,
        where: '$idField = ?',
        whereArgs: [id]);
    if(result.isEmpty){
      return null;
    }
    final user = MyUser.fromDatabase(result.first);
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