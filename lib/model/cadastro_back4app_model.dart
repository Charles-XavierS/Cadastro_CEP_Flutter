class CadastroBack4AppCEPModel {
  List<Cadastros> cadastros = [];

  CadastroBack4AppCEPModel(this.cadastros, {String? cep});

  CadastroBack4AppCEPModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      cadastros = <Cadastros>[];
      json['results'].forEach((v) {
        cadastros.add(Cadastros.fromJson(v));
      });
    }
  }

  get objectId => null;

  get cep => null;

  get logradouro => null;

  get numero => null;

  get complemento => null;

  get bairro => null;

  get localidade => null;

  get estado => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = cadastros.map((v) => v.toJson()).toList();
    return data;
  }

  toCreateJson() {}

  where(bool Function(dynamic c) param0) {}
}

class Cadastros {
  String? objectId = '';
  int cep = 0;
  String logradouro = '';
  int numero = 0;
  String complemento = '';
  String bairro = '';
  String localidade = '';
  String estado = '';

  Cadastros({
    this.objectId,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.estado,
  });

  Cadastros.criar({
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.estado,
  });

  Cadastros.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['numero'] = numero;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['estado'] = estado;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['numero'] = numero;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['estado'] = estado;
    return data;
  }
}
