import 'dart:async';

import 'package:flutter/material.dart';

import '../model/cadastro_back4app_model.dart';
import '../repositories/cadastro_back4app_repository.dart';
import '../widgets/custom_text.dart';
import 'atualizar_page.dart';

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

  void deletar(id) async {
    await cadastroRepository.deletarCadastro(id);
    setState(() {
      _isLoading = true;
      _cadastros.cadastros.removeWhere((cadastro) => cadastro.objectId == id);
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  title: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: resultados.logradouro,
                                          isBold: true,
                                        ),
                                        const CustomText(
                                          text: ', ',
                                          fontSize: 18,
                                          isBold: true,
                                        ),
                                        CustomText(
                                          text: resultados.numero.toString(),
                                          isBold: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: resultados.complemento,
                                        fontSize: 16,
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                            text: resultados.bairro,
                                            fontSize: 16,
                                          ),
                                          const CustomText(
                                            text: ', ',
                                            fontSize: 16,
                                          ),
                                          CustomText(
                                            text: resultados.localidade,
                                            fontSize: 16,
                                          ),
                                          const CustomText(
                                            text: ', ',
                                            fontSize: 16,
                                          ),
                                          CustomText(
                                            text: resultados.estado,
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: resultados.cep.toString(),
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  trailing: PopupMenuButton(
                                    icon: const Icon(Icons.more_vert),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: ListTile(
                                              leading: const Icon(Icons.edit),
                                              title: const Text("Editar"),
                                              onTap: () async {
                                                final result =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditarEnderecoPage(
                                                      cadastro: resultados,
                                                      cadastroRepository:
                                                          cadastroRepository,
                                                      objectId: resultados
                                                          .objectId
                                                          .toString(),
                                                    ),
                                                  ),
                                                );

                                                if (result == true) {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  obterCadastros();
                                                  Timer(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              }),
                                        ),
                                        PopupMenuItem(
                                          child: ListTile(
                                            leading: const Icon(Icons.delete),
                                            title: const Text("Excluir"),
                                            onTap: () {
                                              deletar(resultados.objectId);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
