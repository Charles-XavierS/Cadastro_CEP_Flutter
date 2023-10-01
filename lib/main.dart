import 'package:cadastro_cep/model/cadastro_back4app_model.dart';
import 'package:cadastro_cep/repositories/cadastro_back4app_repository.dart';
import 'package:flutter/material.dart';

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
        // useMaterial3: true, // Remova essa linha, pois não é mais necessária no Flutter 2.0+
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

  @override
  void initState() {
    super.initState();
    obterCadastros();
  }

  void obterCadastros() async {
    _cadastros = await cadastroRepository.obterCadastros();
    setState(() {});
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
                        Text(resultados.complemento),
                        Text(resultados.bairro),
                        Text(resultados.localidade),
                        Text(resultados.estado),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
