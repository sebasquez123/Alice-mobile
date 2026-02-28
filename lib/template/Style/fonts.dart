import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontProvider {
  const FontProvider._();
  static TextStyle get h1 => TextStyle(
        fontFamily: GoogleFonts.lato().fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
  static TextStyle get h2 => TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );
  static TextStyle get h3 => TextStyle(
        fontFamily: GoogleFonts.acme().fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );
  static TextStyle get subtitle => TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      );
  static TextStyle get body => TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      );
  static TextStyle get caption => TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Colors.black45,
      );
}