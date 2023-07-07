import 'package:flutter/material.dart';

class CircularIconButtonWidget extends StatelessWidget {
  String fieldName;

  CircularIconButtonWidget(
      {required formKey, required this.fieldName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO CircularIconButton gedrückt ?
        //formKey.currentState!.fields[fieldName]!.didChange("");
      },
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Icon(
          size: 16,
          Icons.clear,
          color: Colors.white,
        ),
      ),
    );
  }
}
