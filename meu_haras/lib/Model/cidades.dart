class Cidade {
  String id;
  String nome;
  String ufId;

  Cidade({this.id, this.nome, this.ufId});

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nome": this.nome,
        "Uf_Id": this.ufId,
      };

  factory Cidade.fromJson(Map<String, dynamic> json) => Cidade(
        id: json["id"],
        nome: json["nome"],
        ufId: json["Uf_Id"],
      );
}
