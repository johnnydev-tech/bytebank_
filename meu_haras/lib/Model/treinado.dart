class Treinado {
  String id;
  String nome;

  Treinado({this.id, this.nome});

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nome": this.nome,
      };

  factory Treinado.fromJson(Map<String, dynamic> json) => Treinado(
        id: json["id"].toString(),
        nome: json["nome"],
      );
}
