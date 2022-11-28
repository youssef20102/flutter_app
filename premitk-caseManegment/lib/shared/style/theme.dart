// @dart=2.9
import 'package:flutter/material.dart';
import 'package:primitk_crm/shared/style/color.dart';





class LightTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor:Colors.blueGrey[40],
        appBarTheme: AppBarTheme(
            color: Colors.white,
            centerTitle: false,
            elevation: 0,
            iconTheme: IconThemeData(color: selectedColor),
            titleTextStyle: TextStyle(
                color: selectedColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
            titleSpacing: 5.0,
            actionsIconTheme: IconThemeData(color: selectedColor)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: selectedColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blueAccent,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle:
                TextStyle(color: unselectedColor, fontWeight: FontWeight.w500),
            selectedLabelStyle:
                TextStyle(color: indigoColor, fontWeight: FontWeight.w500),
            unselectedItemColor: selectedColor,
            showUnselectedLabels: false),





    );

  }
}

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor:Colors.black12,
      appBarTheme: AppBarTheme(
          color: Colors.black12,
          elevation: 0,
          iconTheme: IconThemeData(color: selectedColor),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
          actionsIconTheme: const IconThemeData(color: Colors.black)),
      cardColor: Colors.black12,

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: selectedColor,
      ),
    );
  }
}
