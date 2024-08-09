import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static Color primaryColor = const Color(0xffDFECDB);
  static Color secondaryColor = const Color(0xff5D9CEC);
  static Color grayColor = const Color(0xffC8C9CB);
  static Color secondaryGrayColor = const Color(0xffA9A9A9);
  static Color primaryDarkColor = const Color(0xff060E1E);
  static Color secondaryDarkColor = const Color(0xff141922);
  static Color grayDarkColor = const Color(0xff707070);
  static Color secondaryDarkGrayColor = const Color(0xffCDCACA);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: secondaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: secondaryColor,
      unselectedItemColor: grayColor,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: MyThemeData.white, width: 4)),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      color: white,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
          fontSize: 24, fontWeight: FontWeight.w700, color: white),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w700, color: secondaryColor),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: const Color(0xff363636),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primaryDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: secondaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: secondaryColor,
      unselectedItemColor: grayColor,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      hoverColor: const Color(0xffCCCCCC),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: MyThemeData.secondaryDarkColor, width: 4)),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      color: secondaryDarkColor,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
          fontSize: 25, fontWeight: FontWeight.w700, color: primaryDarkColor),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: secondaryDarkGrayColor),
      bodySmall: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: white,
      ),
    ),
  );
}
