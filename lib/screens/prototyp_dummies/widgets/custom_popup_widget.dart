import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPopUp {
  String title = "title";
  String button1Text = "Anfrage";
  Widget content;
  Function(String)? callback;

  CustomPopUp({
    required this.title,
    required this.content,
    this.button1Text = "Anfrage",
    this.callback = null,
  });

  Future<int?> showCustomDialog(BuildContext context) async {
    return showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          titlePadding: EdgeInsets.only(top: 20),
          titleTextStyle: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          title: Container(
            width: double.infinity,
            child: Center(
              child: Text(
                this.title,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                content,
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (callback != null) {
                      callback!("wert");
                    }
                    Navigator.pop<int>(context, 1);
                  },
                  child: Container(
                    width: 122,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 194, 223, 222),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                          this.button1Text,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
