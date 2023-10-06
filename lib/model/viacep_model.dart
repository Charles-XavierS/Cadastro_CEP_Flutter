class ViaCEPModel {
  late String cep;
  late String logradouro;
  late String complemento;
  late String bairro;
  late String localidade;
  late String uf;
  late String ibge;
  late String gia;
  late String ddd;
  late String siafi;

  ViaCEPModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  ViaCEPModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'] ?? '';
    logradouro = json['logradouro'] ?? '';
    complemento = json['complemento'] ?? '';
    bairro = json['bairro'] ?? '';
    localidade = json['localidade'] ?? '';
    uf = json['uf'] ?? '';
    ibge = json['ibge'] ?? '';
    gia = json['gia'] ?? '';
    ddd = json['ddd'] ?? '';
    siafi = json['siafi'] ?? '';

    // Substituir valores vazios por ''
    cep = cep.isEmpty ? '' : cep;
    logradouro = logradouro.isEmpty ? '' : logradouro;
    complemento = complemento.isEmpty ? '' : complemento;
    bairro = bairro.isEmpty ? '' : bairro;
    localidade = localidade.isEmpty ? '' : localidade;
    uf = uf.isEmpty ? '' : uf;
    ibge = ibge.isEmpty ? '' : ibge;
    gia = gia.isEmpty ? '' : gia;
    ddd = ddd.isEmpty ? '' : ddd;
    siafi = siafi.isEmpty ? '' : siafi;
  }
}
