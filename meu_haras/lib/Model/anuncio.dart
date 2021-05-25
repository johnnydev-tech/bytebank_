class Anuncio {
  final String id;
  final String titulo;
  final String descricao;
  final String nomeAnunciante;
  final String whatsapp;
  final String pelagem;
  final String raca;
  final String genero;
  final String treinado;
  final String habilidade;
  final String idade;
  final String preco;
  final String data;
  final String thumb;
  final String cidade;
  final bool parcela;
  final bool troca;
  final String produto;
  final String registro;
  final String embriao;
  final String nRegistro;
  final String garanhao;
  final String regGaranhao;
  final String matriz;
  final String regMatriz;
  final String linhagem;

  Anuncio({
    this.id,
    this.titulo,
    this.descricao,
    this.nomeAnunciante,
    this.whatsapp,
    this.pelagem,
    this.raca,
    this.genero,
    this.treinado,
    this.habilidade,
    this.idade,
    this.preco,
    this.data,
    this.thumb,
    this.parcela,
    this.troca,
    this.cidade,
    this.produto,
    this.registro,
    this.embriao,
    this.nRegistro,
    this.garanhao,
    this.regGaranhao,
    this.matriz,
    this.regMatriz,
    this.linhagem,
  });

  factory Anuncio.fromJsom(Map<String, dynamic> json) {
    return Anuncio(
      id: json["id"].toString(),
      titulo: json["titulo"] ?? '',
      descricao: json["descricao"] ?? '',
      nomeAnunciante: json["nomeAnunciante"] ?? '',
      whatsapp: json["whatsapp"] ?? '',
      pelagem: json["pelagem"] ?? '',
      raca: json["raca"] ?? '',
      genero: json["genero"] ?? '',
      treinado: json["treinado"] ?? '',
      habilidade: json["habilidade"] ?? '',
      idade: json["idade"] ?? '',
      preco: json["preco"] ?? '',
      data: json["data"] ?? '',
      thumb: json["thumb"] ?? '',
      parcela: json["parcela"],
      troca: json["troca"],
      cidade: json["cidade"] ?? '',
      produto: json['produto'] ?? '',
      registro: json["registro"] ?? '',
      embriao: json["embriao"] ?? '',
      nRegistro: json["numeroRegistro"] ?? '',
      garanhao: json["garanhao"] ?? '',
      regGaranhao: json["regGaranhao"] ?? '',
      matriz: json["matriz"] ?? '',
      regMatriz: json["regMatriz"] ?? '',
      linhagem: json['linhagem' ?? ''],
    );
  }
}
