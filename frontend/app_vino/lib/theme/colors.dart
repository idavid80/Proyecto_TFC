import 'package:flutter/material.dart';


class WineAppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFF800020), // Borgoña
      colorScheme:  const ColorScheme(
        primary:  Color(0xFF800020), // Borgoña
        secondary:  Color(0xFFD4AF37), // Oro
        tertiary: Color(0xFF808000),
        surface:  Color(0xFFFFFDD0),
        error: Colors.red,
        onPrimary:  Color(0xFFFFFDD0), 
        onSecondary:  Color(0xFF000000),
        onSurface:  Color(0xFF808000),
        onError:  Color(0xFFFFFDD0),
        brightness: Brightness.light,
        
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFDD0), // Crema
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color:  Color(0xFF800020), fontSize: 32, fontWeight: FontWeight.bold), // Borgoña
        headlineMedium: TextStyle(color:  Color(0xFF800020), fontSize: 26, fontWeight: FontWeight.bold), // Borgoña
        headlineSmall: TextStyle(color:  Color(0xFFFFFDD0), fontSize: 20, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color:  Color(0xFF808000), fontSize: 20, fontWeight: FontWeight.bold), // Oliva
        titleMedium: TextStyle(color:  Color(0xFFFFFDD0), fontSize: 18, fontWeight: FontWeight.bold), // Gris Pizarra
        bodyLarge: TextStyle(color:  Color(0xFF800020), fontSize: 16, fontWeight: FontWeight.bold), // Borgoña
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor:  Color(0xFF800020), // Borgoña
        titleTextStyle:  TextStyle(color: Color(0xFFFFFDD0), fontSize: 20), // Crema
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4AF37),
          textStyle: const TextStyle(color: Color(0xFFFFFDD0), fontSize: 20)
          ),
      ),
    
    );
  }
  /*      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.elliptical(15, 15)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xffff4000), Color(0xffffcc66)],
          ),
        ), */
}
/*
class WineAppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFF800020), // Borgoña
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFFD4AF37), // Oro
        background: const Color(0xFFFFFDD0), // Crema
      ),
      scaffoldBackgroundColor: Color(0xFFFFFDD0), // Crema
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Color(0xFF800020), fontSize: 32, fontWeight: FontWeight.bold), // Borgoña
        titleMedium: TextStyle(color: Color(0xFF708090)), // Gris Pizarra
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF800020), // Borgoña
        titleTextStyle: TextStyle(color: Color(0xFFFFFDD0), fontSize: 20), // Crema
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFD4AF37), // Oro
        ),
      ),
    );
  }
}
*/
/*
class WineAppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Color(0xFF800020), // Borgoña
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color(0xFFD4AF37), // Oro
    //    background: Color(0xFFFFFDD0), // Crema
      ),
      scaffoldBackgroundColor: Color(0xFFFFFDD0), // Crema
      textTheme: TextTheme(
        headline1: TextStyle(color: Color(0xFF800020), fontSize: 32, fontWeight: FontWeight.bold), // Borgoña
        bodyText1: TextStyle(color: Color(0xFF708090)), // Gris Pizarra
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF800020), // Borgoña
        titleTextStyle: TextStyle(color: Color(0xFFFFFDD0), fontSize: 20), // Crema
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFD4AF37), // Oro
        ),
      ),
    );
  }
}
*/
/*
class WineAppTheme {

  static ThemeData get theme {
    return ThemeData(
      primaryColor: Color(0xFF800020), // Borgoña
      accentColor: Color(0xFFD4AF37), // Oro
      backgroundColor: Color(0xFFFFFDD0), // Crema
      scaffoldBackgroundColor: Color(0xFFFFFDD0), // Crema
      textTheme: TextTheme(
        headline1: TextStyle(color: Color(0xFF800020), fontSize: 32, fontWeight: FontWeight.bold), // Borgoña
        bodyText1: TextStyle(color: Color(0xFF708090)), // Gris Pizarra
      ),
      appBarTheme: AppBarTheme(
        color: Color(0xFF800020), // Borgoña
        titleTextStyle: TextStyle(color: Color(0xFFFFFDD0), fontSize: 20), // Crema
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFFD4AF37), // Oro
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
*/