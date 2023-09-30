class CadastroBack4AppCEP {
  List<Cadastros> cadastros = [];

  CadastroBack4AppCEP(this.cadastros);

  CadastroBack4AppCEP.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      cadastros = <Cadastros>[];
      json['results'].forEach((v) {
        cadastros.add(Cadastros.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = cadastros.map((v) => v.toJson()).toList();
    return data;
  }
}

class Cadastros {
  String objectId = '';
  int cep = 0;
  String logradouro = '';
  String complemento = '';
  String bairro = '';
  String localidade = '';
  String estado = '';
  String createdAt = '';
  String updatedAt = '';

  Cadastros(
      {required this.objectId,
      required this.cep,
      required this.logradouro,
      required this.complemento,
      required this.bairro,
      required this.localidade,
      required this.estado,
      required this.createdAt,
      required this.updatedAt});

  Cadastros.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    estado = json['estado'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['estado'] = estado;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
