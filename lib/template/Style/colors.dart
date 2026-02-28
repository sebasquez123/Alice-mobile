import 'package:flutter/material.dart';

class ColorProvider {
  static Color get primary => const Color.fromRGBO(244, 244, 244, 1);
  static Color get secondary => const Color.fromRGBO(225, 221, 239, 1);
  static Color get tertiary =>  const Color(0xFFEF53DD);
  static Color get quaternary => const Color.fromRGBO(170, 170, 170, 0.329);
  static Color get quinary => const Color.fromRGBO(221, 216, 243, 1);
  static Color get senary => const Color.fromRGBO(221, 216, 243, 1);
  static Color get septenary => const Color.fromARGB(255, 45, 27, 35);
  static Color get octonary => const Color.fromRGBO(29, 23, 72, 1);
  static Color get nonary => const Color.fromRGBO(102, 102, 167, 1);
  static Color get denary =>  const Color.fromRGBO(255, 255, 255, 1);
  static Color get eleventh =>  const Color.fromRGBO(67, 67, 103, 1);
  static Color get twelfth => const Color.fromRGBO(27, 32, 45, 1);
  static Color get thirteenth => const Color.fromRGBO(65, 75, 255, 0.25);
  static Color get fourteenth => const Color.fromRGBO(255, 255, 255, 0.484);
  static Color get fifteenth => const Color.fromRGBO(232, 62, 62, 1);
  static Color get sixteenth => const Color.fromRGBO(133, 242, 116, 1);
  static Color get transparent => Colors.transparent;
  static List<Color> get primaryGradient => [Colors.white, Colors.white, Colors.white];
  static List<Color> get growGradient => [const Color.fromRGBO(189, 189, 189, 1), const Color.fromRGBO(107, 107, 107, 1)];

  static Color get homeBackground => const Color(0xFFF679AB);
  static Color get loginBackground => const Color(0xFFF679AB);
  static Color get quotationBackground => const Color(0xFFF679AB);
  static Color get registryBackground => const Color(0xFFF679AB);
  static Color get termsBackground =>const Color(0xFFF679AB);
  static Color get loadingSpinner => const Color(0xFFEF53DD);
  static Color get loadingThreeBounce => const Color(0xFFEF53DD);


  static List<Color> get degradedCard => const [Color(0xFFFF4973), Color(0xFFFF4973)];
  static List<Color> get chatTextFieldBorderNoFocus => const [
            Color(0xFFF6E232),
            Color.fromARGB(255, 86, 34, 0),
            Color.fromARGB(255, 191, 37, 238),
            Color(0xFFEE25DD),
          ];
}