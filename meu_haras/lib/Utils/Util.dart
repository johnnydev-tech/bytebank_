
String nomemsg = "";
String msgemail = "";
String msg ="";


String validarNome(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return nomemsg = "Informe o nome";
  } else if (!regExp.hasMatch(value)) {
    return nomemsg = "O nome deve conter caracteres de a-z ou A-Z";
  }
  nomemsg = "";
  return null;
}

String validarEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return msgemail = "Informe o Email";
  } else if (!regExp.hasMatch(value)) {
    return msgemail = "Email inválido";
  } else {
    msgemail = "";
    return null;
  }
}

String ValidarSenha(String value) {
  if (value.isEmpty || value.length < 6) {
    return msg =
    "A Senha precisa ter pelo menos 6 caracteres!";
  }
    else{
      msg = "";
      return null;

  }
}




