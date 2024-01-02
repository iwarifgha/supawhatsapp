
import 'package:supabase_flutter/supabase_flutter.dart';

class MySupabaseClient {
  static Future<void> initialize() async {
    await Supabase.initialize(
        url: 'https://klbphmfsiwvrrchuevwi.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtsYnBobWZzaXd2cnJjaHVldndpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg4NTEyNDYsImV4cCI6MjAxNDQyNzI0Nn0.iZw6jAWfXytMeWh_DYiJ-dDYUkzCsXpAGKVMo0w8qTk'
    );
  }

  static final supabase = Supabase.instance.client;
}
