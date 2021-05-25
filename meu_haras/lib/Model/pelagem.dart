class Pelagem {
  String id;
  String nome;

  Pelagem({this.id, this.nome});

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nome": this.nome,
      };

  factory Pelagem.fromJson(Map<String, dynamic> json) => Pelagem(
        id: json["id"].toString(),
        nome: json["nome"],
      );
}
