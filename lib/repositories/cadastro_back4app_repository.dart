import 'package:cadastro_cep/model/cadastro_back4app_model.dart';
import 'package:dio/dio.dart';

class CadastroBack4AppRepository {
  Future<CadastroBack4AppCEPModel> obterCadastros() async {
    var dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] =
        'ZW5MnH7abyPHDOLX7RubnT2pSGzm0v4oYCVKRGMh';
    dio.options.headers['X-Parse-REST-API-Key'] =
        '2tQQxDwA2LIfDMqNcws5DnoLzNBmUafQOyyd0R1g';
    dio.options.headers['content-type'] = 'application/json';
    var result = await dio.get('https://parseapi.back4app.com/classes/CEP');
    return CadastroBack4AppCEPModel.fromJson(result.data);
  }
}
