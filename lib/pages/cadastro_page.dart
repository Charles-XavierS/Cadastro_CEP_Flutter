import 'package:flutter/material.dart';
import 'package:cadastro_cep/model/cadastro_back4app_model.dart';
import 'package:cadastro_cep/repositories/cadastro_back4app_repository.dart';

import '../model/viacep_model.dart';
import '../repositories/viacepe_api_repository.dart';
import '../widgets/custom_textfield.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  var viaCEPRepository = ViaCEPRepository();
  CadastroBack4AppRepository cadastroRepository = CadastroBack4AppRepository();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final String _mensagem = "";

  @override
  void initState() {
    super.initState();
    obterCadastros();
  }

  void obterCadastros() async {
    await cadastroRepository.obterCadastros();
    setState(() {});
  }

  Future<void> verificarCadastro(
    int cep,
    int numero,
    String complemento,
  ) async {
    var cadastroModel = await cadastroRepository.obterCadastros();
    var cadastros = cadastroModel.cadastros;

    for (var cadastro in cadastros) {
      if (cadastro.cep == cep &&
          cadastro.numero == numero &&
          cadastro.complemento == complemento) {
        mostrarDialog(
          "Endereço já cadastrado",
          "Este endereço já existe no sistema.",
        );
        return;
      }
    }

    await fazerCadastro();
  }

  Future<void> fazerCadastro() async {
    String cepString = _cepController.text.replaceAll("-", "");
    int? cepInt = int.tryParse(cepString);
    int? numero = int.tryParse(_numeroController.text);

    await cadastroRepository.fazerCadastro(Cadastros.criar(
      cep: cepInt ?? 0,
      logradouro: _logradouroController.text,
      numero: numero ?? 0,
      complemento: _complementoController.text,
      bairro: _bairroController.text,
      localidade: _cidadeController.text,
      estado: _estadoController.text,
    ));

    mostrarDialog("Endereço salvo", "Endereço salvo com sucesso!");

    setState(() {
      _cepController.clear();
      _numeroController.clear();
      _complementoController.clear();
    });
  }

  void mostrarDialog(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          CustomTextFormField(
            labelText: 'Digite o CEP (apenas números)',
            maxLength: 8,
            keyboardType: TextInputType.number,
            controller: _cepController,
            onChanged: (String value) async {
              if (value.length == 8) {
                ViaCEPModel endereco =
                    await viaCEPRepository.consultarCep(value);
                _logradouroController.text = endereco.logradouro;
                _bairroController.text = endereco.bairro;
                _cidadeController.text = endereco.localidade;
                _estadoController.text = endereco.uf;
              }
            },
          ),
          CustomTextFormField(
            labelText: 'Logradouro',
            controller: _logradouroController,
            enabled: false,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  labelText: 'Número',
                  keyboardType: TextInputType.number,
                  controller: _numeroController,
                  enabled: true,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  labelText: 'Complemento',
                  controller: _complementoController,
                  enabled: true,
                ),
              ),
            ],
          ),
          CustomTextFormField(
            labelText: 'Bairro',
            controller: _bairroController,
            enabled: false,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  labelText: 'Cidade',
                  controller: _cidadeController,
                  enabled: false,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  labelText: 'Estado',
                  controller: _estadoController,
                  enabled: false,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              int? cep = int.tryParse(_cepController.text);
              verificarCadastro(
                cep!,
                int.tryParse(_numeroController.text) ?? 0,
                _complementoController.text,
              );
            },
            child: const Text(
              'Salvar',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 17, letterSpacing: 1),
            ),
          ),
          Text(_mensagem),
        ],
      ),
    );
  }
}
