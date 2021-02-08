import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

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
                    stream: _loginBloc.outEmail,
                    onChanget: _loginBloc.changeEmail,
                  ),
                  InputField(
                    iconData: Icons.lock_outline,
                    hint: 'Senha',
                    obscure: true,
                    stream: _loginBloc.outSenha,
                    onChanget: _loginBloc.changeSenha,
                  ),
                  SizedBox(height: 32),
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.pinkAccent,
                          child: Text('Entrar'),
                          onPressed:
                              snapshot.hasData ? _loginBloc.submit : null,
                          textColor: Colors.white,
                          disabledColor: Colors.pinkAccent.withAlpha(140),
                        ),
                      );
                    },
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
