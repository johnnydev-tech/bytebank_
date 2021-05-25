class Uf {
  Uf({
    this.id,
    this.nome,
    this.sigla,
  });

  String id;
  String nome;
  String sigla;

  factory Uf.fromJson(Map<String, dynamic> json) => Uf(
        id: json["id"].toString(),
        nome: json["nome"],
        sigla: json["sigla"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "sigla": sigla,
      };
}
