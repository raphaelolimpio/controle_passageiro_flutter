import 'package:controleusuario/app/views/cadastro/cadastro_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:controleusuario/app/DesignSystem/Componets/ListCard/list_card.dart';
import 'package:controleusuario/app/DesignSystem/Componets/Card/custom_card_view_mode.dart';
import 'package:controleusuario/app/DesignSystem/shared/colors.dart';

import '../../DataBase/services/api_service.dart';
import '../../DataBase/usuario/usuarrio.dart';

class HomeViewMode extends StatefulWidget {
  const HomeViewMode({Key? key}) : super(key: key);

  @override
  State<HomeViewMode> createState() => _HomeViewModeState();
}

class _HomeViewModeState extends State<HomeViewMode> {
  final ApiService apiService = ApiService();
  List<CustomCardViewMode> cardItems = [];

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  // Carregar usuários e configurar o modelo de visualização para cada cartão
  Future<void> _loadUsuarios() async {
    print("Iniciando carregamento de usuários...");
    try {
      List<Usuario> usuarios =
          await apiService.fetchUsuarios().timeout(const Duration(seconds: 10));
      print("Usuários carregados com sucesso.");
      setState(() {
        cardItems = usuarios.map((usuario) {
          return CustomCardViewMode.fromUsuario(usuario);
        }).toList();
      });
    } catch (e) {
      print("Erro ao carregar usuários: $e");
      setState(() {
        cardItems = []; // Limpa a lista se ocorrer um erro
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar usuários: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Home"),
          backgroundColor: PagerTwoColor,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PagerTwoColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroViewMode()));
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: cardItems.isNotEmpty
              ? ListCard(cards: cardItems)
              : const Center(
                  child: CircularProgressIndicator()), // Exibe carregamento
        ),
      ),
    );
  }
}
