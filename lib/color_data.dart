import 'package:flutter/material.dart';

// var dominantColor =
//     HSLColor.fromColor(Colors.purple).withLightness(95).toColor();
// var secondaryColor =
//     HSLColor.fromColor(Colors.purple).withLightness(10).toColor();
// // HSLColor.fromColor(Colors.purple).withLightness(70).toColor();
// Color accentColor =
//     HSLColor.fromColor(Colors.purple).withLightness(65).toColor();
// // var foregroundColor =
// //     HSLColor.fromColor(Colors.purple).withLightness(10).toColor();
// // var temp = const Color(0xFF9C29B0);

Color dominantColor = const Color(0xFFE3F8FF);
Color secondaryColor = const Color(0xFF273038);
Color accentColor = const Color.fromARGB(255, 94, 223, 255);
Color dominantColor2 =
    Color.alphaBlend(Colors.white.withOpacity(0.7), accentColor);

ThemeData theme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: accentColor,
  ),
  colorScheme: ColorScheme.fromSwatch(accentColor: accentColor),
  scaffoldBackgroundColor: dominantColor,
  // iconTheme: IconThemeData(color: secondaryColor),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: secondaryColor),
  textTheme: const TextTheme().copyWith().apply(
        bodyColor: secondaryColor,
        displayColor: secondaryColor,
      ),
);

ThemeData fTheme(BuildContext context) => ThemeData(
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: accentColor,
      ),
      colorScheme: ColorScheme.fromSwatch(accentColor: accentColor),
      scaffoldBackgroundColor: dominantColor,
      listTileTheme: ListTileThemeData(
        tileColor: dominantColor2,
        textColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(accentColor),
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          foregroundColor: MaterialStatePropertyAll<Color>(secondaryColor),
        ),
      ),
      dialogBackgroundColor: dominantColor,

      // iconTheme: IconThemeData(color: secondaryColor),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: secondaryColor),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: secondaryColor,
            displayColor: secondaryColor,
          ),
    );

InputDecoration kTextInputDecoration(String hintText) => InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: accentColor,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: secondaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );

var kElevatedbutton = ElevatedButton.styleFrom(
  backgroundColor: accentColor,
);
