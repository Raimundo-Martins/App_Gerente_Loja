import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final bool obscure;

  InputField(
      {@required this.iconData, @required this.hint, @required this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          icon: Icon(iconData, color: Colors.white),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pinkAccent,
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 5, right: 30, top: 30, bottom: 30)),
      style: TextStyle(color: Colors.white),
      obscureText: obscure,
    );
  }
}
