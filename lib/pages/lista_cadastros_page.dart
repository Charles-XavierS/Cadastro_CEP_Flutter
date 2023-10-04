import 'dart:async';

import 'package:flutter/material.dart';

import '../model/cadastro_back4app_model.dart';
import '../repositories/cadastro_back4app_repository.dart';

class ListaEnderecos extends StatefulWidget {
  const ListaEnderecos({super.key});

  @override
  State<ListaEnderecos> createState() => _ListaEnderecosState();
}

class _ListaEnderecosState extends State<ListaEnderecos> {
  var _cadastros = CadastroBack4AppCEPModel([]);
  CadastroBack4AppRepository cadastroRepository = CadastroBack4AppRepository();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    obterCadastros();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void obterCadastros() async {
    _cadastros = await cadastroRepository.obterCadastros();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : Column(
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
              ],
            ),
    );
  }
}
