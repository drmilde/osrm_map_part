import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';


class AppConstants {
  Color white = Color.fromARGB(255, 255, 255, 255);
  Color black = Color.fromARGB(255, 0, 0, 0);
  Color warning = Color.fromARGB(255, 255, 83, 83);
  Color primary_color = Color.fromARGB(255, 219, 237, 236);
  Color primary_color_dark = Color.fromARGB(255, 110, 140, 137);
  Color secondary_color = Color.fromARGB(255, 191, 220, 219);
  Color secondary_color_dark = Color.fromARGB(255, 137, 175, 173);
  Color button_dark = Color.fromARGB(255, 14, 116, 114);

  double headerFontsSize = 24;

  Color light_grey = Color.fromARGB(255, 202, 211, 211);
  Color turquoise = Color.fromARGB(255, 0, 173, 167);
  Color light_green = Color.fromARGB(255, 139, 208, 106);
  Color dark_grey = Color.fromARGB(255, 28, 31, 31);

  // Positionen
  LatLng Hochschule_MAIN = LatLng(50.564649, 9.687922);
  String Hochschule_MAIN_Coord_String = "9.687922,50.564649";

  LatLng Hochschule_P1 = LatLng(50.56507, 9.683541);
  String Hochschule_P1_Coord_String = "9.683541,50.56507";

  LatLng Hochschule_P2 = LatLng(50.566128, 9.683249);
  String Hochschule_P2_Coord_String = "9.683249,50.566128";

  LatLng Hochschule_P3 = LatLng(50.569934, 9.686996);
  String Hochschule_P3_Coord_String = "9.686996,50.569934";


  String passwortFuerTokenEntschluesslung = "geheim123";

  AppConstants() {
  }
}
