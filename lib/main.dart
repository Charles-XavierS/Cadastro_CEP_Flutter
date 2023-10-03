import 'package:cadastro_cep/model/cadastro_back4app_model.dart';
import 'package:cadastro_cep/repositories/cadastro_back4app_repository.dart';
import 'package:flutter/material.dart';

import 'model/viacep_model.dart';
import 'repositories/viacepe_api_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CadastroBack4AppRepository cadastroRepository = CadastroBack4AppRepository();
  var _cadastros = CadastroBack4AppCEPModel([]);
  final TextEditingController _cepController = TextEditingController();
  String _mensagem = "";

  @override
  void initState() {
    super.initState();
    obterCadastros();
  }

  void obterCadastros() async {
    _cadastros = await cadastroRepository.obterCadastros();
    setState(() {});
  }

  Future<void> _buscarEndereco() async {
    final cep = _cepController.text;
    if (cep.isEmpty) {
      setState(() {
        _mensagem = "Digite um CEP válido.";
      });
      return;
    }

    try {
      final endereco = await ViaCEPRepository().consultarCep(cep);
      final enderecoExiste =
          await cadastroRepository.enderecoExisteNoBack4App(cep);

      if (enderecoExiste) {
        setState(() {
          _mensagem = "Este endereço já está cadastrado no Back4App.";
        });
      } else {
        final result = await _mostrarDialogoSalvarEndereco(endereco);

        if (result == true) {
        } else {
          setState(() {
            _mensagem = "Endereço não foi salvo.";
          });
        }
      }
    } catch (e) {
      // Trate erros aqui
      setState(() {
        _mensagem = "Erro ao buscar o endereço.";
      });
    }
  }

  Future<bool?> _mostrarDialogoSalvarEndereco(ViaCEPModel endereco) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Salvar Endereço'),
        content: const Text('Deseja salvar este endereço no Back4App?'),
        actions: [
          TextButton(
            onPressed: () async {
              await fazerCadastro(endereco);
              Navigator.of(context).pop(true);
            },
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Não'),
          ),
        ],
      ),
    );
  }

  Future<void> fazerCadastro(ViaCEPModel endereco) async {
    String? cepString = endereco.cep.replaceAll("-", "");
    int? cepInt = int.tryParse(cepString);
    int? numero = int.tryParse(endereco.complemento);

    var novo = await cadastroRepository.fazerCadastro(Cadastros.criar(
      cep: cepInt ?? 0,
      logradouro: endereco.logradouro,
      numero: numero ?? 0,
      complemento: endereco.complemento,
      bairro: endereco.bairro,
      localidade: endereco.localidade,
      estado: endereco.uf,
    ));

    try {
      setState(() {
        novo;
        _mensagem = "Endereço salvo com sucesso!";
        _cepController.clear();
        obterCadastros();
      });
    } catch (e) {
      setState(() {
        _mensagem = "Erro ao salvar o endereço.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cadastros.cadastros.length,
                itemBuilder: (BuildContext bc, int index) {
                  var resultados = _cadastros.cadastros[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(resultados.cep.toString()),
                        Text(resultados.logradouro),
                        Text(resultados.numero.toString()),
                        Text(resultados.bairro),
                        Text(resultados.localidade),
                        Text(resultados.estado),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'Digite o CEP'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _buscarEndereco(),
              child: const Text('Buscar Endereço'),
            ),
            Text(_mensagem),
          ],
        ),
      ),
    );
  }
}
