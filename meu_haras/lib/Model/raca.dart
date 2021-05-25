class Raca {
  String id;
  String nome;

  Raca({this.id, this.nome});

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nome": this.nome,
      };

  factory Raca.fromJson(Map<String, dynamic> json) => Raca(
        id: json["id"].toString(),
        nome: json["nome"],
      );
}
