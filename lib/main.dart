import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/helpers/utils/locator.dart';
import 'package:whatsapp_clone/supabase.dart';
import 'controller/state/startup/startup_cubit.dart';
import 'controller/state/startup/startup_logic.dart';
import 'helpers/theme/theme.dart';

void main() {
  MySupabaseClient.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SupaWhatsapp',
      theme:  appTheme,
      home:  BlocProvider(
        create: (context) => StartUpCubit(),
        child: StartUpLogic(),
      ),
    );
  }
}




