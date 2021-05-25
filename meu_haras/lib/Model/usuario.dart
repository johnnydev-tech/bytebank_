import 'dart:convert';

class UsuarioModel {
  UsuarioModel({
    this.id,
    this.username,
    this.nome,
    this.password,
    this.rolesId,
    this.apiToken,
    this.pin,
  });

  int id;
  String username;
  String nome;
  String password;
  int rolesId;
  String apiToken;
  String pin;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json['id'],
        username: json['username'],
        nome: json['nome'],
        password: json['password'],
        rolesId: json['Roles_id'],
        apiToken: json['api_token'],
        pin: json['pin'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'nome': nome,
        'password': password,
        'Roles_id': rolesId,
        'api_token': apiToken,
        'pin': pin,
      };
}

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());
