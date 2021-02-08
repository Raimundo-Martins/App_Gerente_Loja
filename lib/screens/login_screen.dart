import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.pinkAccent,
                    size: 160,
                  ),
                  InputField(
                    iconData: Icons.person_outline,
                    hint: 'Usuário',
                    obscure: false,
                  ),
                  InputField(
                    iconData: Icons.lock_outline,
                    hint: 'Senha',
                    obscure: true,
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    child: RaisedButton(
                      color: Colors.pinkAccent,
                      child: Text('Entrar'),
                      onPressed: null,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
