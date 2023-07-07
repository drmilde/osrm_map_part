import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osrm_map_part/config/app_constants.dart';

class CustomRoundButton extends StatelessWidget {
  AppConstants appConstants = AppConstants();
  VoidCallback callback;
  String text;
  double width = 220;
  double height = 45;
  Color? color;
  Color? textColor;
  bool showShadow = false;
  bool isDense = false;

  CustomRoundButton(
      {required this.text,
      required this.callback,
      this.color = null,
      this.textColor,
      this.width = 220,
      this.height = 45,
      this.showShadow = false,
      this.isDense = false,
      Key? key})
      : super(key: key) {
    color = color ?? appConstants.button_dark;
    textColor = textColor ?? appConstants.black;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: isDense? 32: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(height / 5),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: textColor,
              //fontWeight: FontWeight.bold,
              fontSize: isDense? 16: 20,
            ),
          ),
        ),
      ),
    );
  }
}
