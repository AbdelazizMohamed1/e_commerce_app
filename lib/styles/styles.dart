import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme() => ThemeData(
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        bodyText2: TextStyle(
          color: Colors.black87,
          fontSize: 16.0,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.deepOrange,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.red,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed),
      dividerColor: HexColor("#808080"),
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.black87),
        iconTheme: IconThemeData(color: Colors.black87),
        titleSpacing: 20.0,
        titleTextStyle: TextStyle(
            color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );

ThemeData darkTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.grey,
      dividerColor: HexColor("#ffffff"),
      //  dividerTheme: DividerThemeData(
      //    color: Colors.white
      //  ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.red,
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.grey,
        ),
        backwardsCompatibility: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
