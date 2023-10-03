import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cadastro_cep/model/viacep_model.dart';

class ViaCEPRepository {
  Future<ViaCEPModel> consultarCep(String cep) async {
    var response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCEPModel.fromJson(json);
    }
    return ViaCEPModel(
        cep: '',
        logradouro: '',
        complemento: '',
        bairro: '',
        localidade: '',
        uf: '',
        ibge: '',
        gia: '',
        ddd: '',
        siafi: '');
  }
}
