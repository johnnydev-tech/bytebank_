class Imagem {
  String id;
  String imagem;

  Imagem({this.id, this.imagem});


  factory Imagem.fromJsom(Map<String, dynamic> json){
    return Imagem(
      id: json["id"].toString(),
      imagem: json["imagem"],
    );
  }
}