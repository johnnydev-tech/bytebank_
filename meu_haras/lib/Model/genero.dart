class Genero {
  String id;
  String nome;

  Genero({this.id, this.nome});

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nome": this.nome,
      };

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
        id: json["id"],
        nome: json["nome"],
      );
}
