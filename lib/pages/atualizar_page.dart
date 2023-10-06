import 'package:flutter/material.dart';
import 'package:cadastro_cep/model/cadastro_back4app_model.dart';
import 'package:cadastro_cep/repositories/cadastro_back4app_repository.dart';
import 'package:cadastro_cep/widgets/custom_textfield.dart';

class EditarEnderecoPage extends StatefulWidget {
  final Cadastros cadastro;
  final CadastroBack4AppRepository cadastroRepository;
  final String objectId;

  const EditarEnderecoPage({
    Key? key,
    required this.cadastro,
    required this.cadastroRepository,
    required this.objectId,
  }) : super(key: key);

  @override
  EditarEnderecoPageState createState() => EditarEnderecoPageState();
}

class EditarEnderecoPageState extends State<EditarEnderecoPage> {
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cepController.text = widget.cadastro.cep.toString();
    _logradouroController.text = widget.cadastro.logradouro;
    _numeroController.text = widget.cadastro.numero.toString();
    _complementoController.text = widget.cadastro.complemento;
    _bairroController.text = widget.cadastro.bairro;
    _cidadeController.text = widget.cadastro.localidade;
    _estadoController.text = widget.cadastro.estado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextFormField(
              labelText: 'CEP (apenas números)',
              controller: _cepController,
              keyboardType: TextInputType.number,
              maxLength: 8,
            ),
            CustomTextFormField(
              labelText: 'Logradouro',
              controller: _logradouroController,
            ),
            CustomTextFormField(
              labelText: 'Número',
              controller: _numeroController,
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              labelText: 'Complemento',
              controller: _complementoController,
            ),
            CustomTextFormField(
              labelText: 'Bairro',
              controller: _bairroController,
            ),
            CustomTextFormField(
              labelText: 'Cidade',
              controller: _cidadeController,
            ),
            CustomTextFormField(
              labelText: 'Estado',
              controller: _estadoController,
            ),
            ElevatedButton(
              onPressed: () async {
                final cadastroAtualizado = Cadastros(
                  objectId: widget.objectId,
                  cep: int.tryParse(_cepController.text) ?? 0,
                  logradouro: _logradouroController.text,
                  numero: int.tryParse(_numeroController.text) ?? 0,
                  complemento: _complementoController.text,
                  bairro: _bairroController.text,
                  localidade: _cidadeController.text,
                  estado: _estadoController.text,
                );

                try {
                  await widget.cadastroRepository.atualizarCadastro(
                    widget.objectId,
                    cadastroAtualizado,
                  );

                  Navigator.pop(context, true);
                } catch (e) {
                  throw ('Erro ao atualizar cadastro: $e');
                }
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
