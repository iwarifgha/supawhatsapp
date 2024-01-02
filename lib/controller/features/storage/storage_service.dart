
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../supabase_client.dart';

class StorageService{

  //StorageService._singleton();
  //static final StorageService instance = StorageService._singleton();

  final supabase = MySupabaseClient.supabase;

  String get url => supabase.storageUrl;

  Future<String> uploadFile({
    required File avatarFile,
    required String userId
  }) async {
     final String path = await supabase.storage.from('avatars').upload(
      '$userId/avatar',
      avatarFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
     return path;
  }
}