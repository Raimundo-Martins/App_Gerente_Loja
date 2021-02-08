import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanget;

  InputField(
      {@required this.iconData,
      @required this.hint,
      @required this.obscure,
      @required this.stream,
      @required this.onChanget});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanget,
          decoration: InputDecoration(
              icon: Icon(iconData, color: Colors.white),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.pinkAccent,
                ),
              ),
              contentPadding: EdgeInsets.only(
                left: 5,
                right: 30,
                top: 30,
                bottom: 30,
              ),
              errorText: snapshot.hasError ? snapshot.error : null),
          style: TextStyle(color: Colors.white),
          obscureText: obscure,
        );
      },
    );
  }
}
