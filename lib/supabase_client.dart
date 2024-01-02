
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config.dart';


/*
Uncomment this class and place your own 'url' and 'anonKey' from your own supabase project here.

class Config {
  static const kUrl = 'YOUR_SUPABASE_URL';
  static const kAnonKey = 'YOUR SUPABASE ANON KEY';
 }*/

class MySupabaseClient {
  static Future<void> initialize() async {
    await Supabase.initialize(
        url: Config.kUrl ,
        anonKey: Config.kAnonKey,
    );
  }

  static final supabase = Supabase.instance.client;
}
