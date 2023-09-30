import 'package:cadastro_cep/model/cadastro_back4app_model.dart';
import 'package:dio/dio.dart';

class CadastroBack4AppRepository {
  Future<CadastroBack4AppCEPModel> obterCadastros() async {
    var dio = Dio();
    var result = await dio.get('https://parseapi.back4app.com/classes/CEP');
    return CadastroBack4AppCEPModel.fromJson(result.data);
  }
}
