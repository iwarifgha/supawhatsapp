import 'package:flutter/material.dart';

final appTheme = ThemeData(
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.greenAccent.shade700.withBlue(155).withAlpha(250)
  ),
  bottomSheetTheme:   BottomSheetThemeData(
    backgroundColor: Colors.blueGrey.shade900,
    modalBackgroundColor: Colors.blueGrey.shade900,
    shape: const ContinuousRectangleBorder(),
  ),
    scaffoldBackgroundColor: Colors.blueGrey.shade900.withAlpha(79),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey.shade900
  ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.greenAccent.shade700.withBlue(155).withAlpha(250)
   ),
  //primaryColorDark: Colors.blueGrey,
    colorScheme: ColorScheme.fromSeed(
      surfaceTint: Colors.blueGrey,
      brightness: Brightness.dark,
        seedColor: Colors.greenAccent.shade700.withBlue(155)),
    useMaterial3: true,
);