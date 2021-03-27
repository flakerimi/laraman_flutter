import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData laramanThemeData(BuildContext context) {
  return ThemeData(
    iconTheme: IconThemeData(
      color: Colors.indigo,
      size: 11.2,
    ),
    primarySwatch: Colors.indigo,
    primaryTextTheme: TextTheme(),
    textTheme: GoogleFonts.rubikTextTheme(
      Theme.of(context).textTheme.copyWith(
            headline4: TextStyle(
              fontSize: 30,
              color: Colors.indigo,
            ),
            headline6: TextStyle(
              color: Colors.indigo,
            ),
            headline5: TextStyle(
              color: Colors.indigo,
            ),
            headline1: TextStyle(
              fontSize: 20,
              color: Colors.indigo,
            ),
          ),
    ),
    appBarTheme: AppBarTheme(
        textTheme: TextTheme(),
        color: Colors.indigo,
        iconTheme: IconThemeData(
          color: Colors.indigo,
          size: 11.2,
        )),
  );
}
