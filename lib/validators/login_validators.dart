import 'dart:async';

class LoginValidators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Insira um e-mail válido!');
    }
  });

  final validateSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha.length > 5) {
      sink.add(senha);
    } else {
      sink.addError('Senha válida, deve conter no mínimo 6 caracteres!');
    }
  });
}
