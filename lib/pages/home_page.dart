import 'package:cadastro_cep/pages/cadastro_page.dart';
import 'package:flutter/material.dart';

import 'lista_cadastros_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  int pagePosition = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de endereços'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Opções'),
              ),
            ],
          ),
        ),
        body: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                pagePosition = value;
              });
            },
            children: const [CadastroPage(), ListaEnderecos()]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            pageController.jumpToPage(value);
          },
          currentIndex: pagePosition,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              label: 'Cadastro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              label: 'Salvos',
            ),
          ],
        ),
      ),
    );
  }
}
