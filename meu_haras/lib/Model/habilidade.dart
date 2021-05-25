class Habilidade {
  String id;
  String nome;

  Habilidade({this.id, this.nome});

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nome": this.nome,
      };

  factory Habilidade.fromJson(Map<String, dynamic> json) => Habilidade(
        id: json["id"].toString(),
        nome: json["nome"],
      );
}
