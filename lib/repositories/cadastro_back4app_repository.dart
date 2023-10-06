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

  Future<void> fazerCadastro(Cadastros cadastro) async {
    var dio = Dio();

    try {
      dio.options.headers['X-Parse-Application-Id'] =
          'ZW5MnH7abyPHDOLX7RubnT2pSGzm0v4oYCVKRGMh';
      dio.options.headers['X-Parse-REST-API-Key'] =
          '2tQQxDwA2LIfDMqNcws5DnoLzNBmUafQOyyd0R1g';
      dio.options.headers['Content-Type'] = 'application/json';

      final cadastroJson = cadastro.toCreateJson();

      var result = await dio.post(
        'https://parseapi.back4app.com/classes/CEP',
        data: cadastroJson,
      );
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletarCadastro(String id) async {
    var dio = Dio();
    dio.options.headers['X-Parse-Application-Id'] =
        'ZW5MnH7abyPHDOLX7RubnT2pSGzm0v4oYCVKRGMh';
    dio.options.headers['X-Parse-REST-API-Key'] =
        '2tQQxDwA2LIfDMqNcws5DnoLzNBmUafQOyyd0R1g';
    await dio.delete('https://parseapi.back4app.com/classes/CEP/$id');
  }

  Future<void> atualizarCadastro(String id, Cadastros cadastro) async {
    var dio = Dio();

    try {
      dio.options.headers['X-Parse-Application-Id'] =
          'ZW5MnH7abyPHDOLX7RubnT2pSGzm0v4oYCVKRGMh';
      dio.options.headers['X-Parse-REST-API-Key'] =
          '2tQQxDwA2LIfDMqNcws5DnoLzNBmUafQOyyd0R1g';
      dio.options.headers['Content-Type'] = 'application/json';

      final cadastroJson = cadastro.toCreateJson();

      var result = await dio.put(
        'https://parseapi.back4app.com/classes/CEP/$id',
        data: cadastroJson,
      );

      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
