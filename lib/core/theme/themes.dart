import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle mainAppTextTheme(double size){
  return GoogleFonts.aDLaMDisplay(fontSize: size);
}

TextStyle textTheme(double size,Color color){
  return GoogleFonts.aDLaMDisplay(fontSize: size,color: color);
}

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    secondary: Colors.green,
    primary: Colors.white,
    tertiary: Colors.black38,
    scrim: Colors.grey.shade300,
    surface: Colors.grey.shade300,

  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 36, 36, 36),
    secondary: const Color.fromARGB(255, 70, 140, 72),
    primary: const Color.fromARGB(255, 53, 53, 53),
    tertiary: Colors.grey.shade500,
     scrim: Colors.grey.shade800,
    surface: const Color.fromARGB(255, 36, 36, 36),
  )
);