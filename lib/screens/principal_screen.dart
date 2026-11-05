import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../models/cidade.dart';
import '../repositories/cidade_repository.dart';
import '../services/favoritos_service.dart';
import 'detalhe_cidade_screen.dart';
import 'favoritos_screen.dart';
import 'guia_screen.dart';
import 'inicio_screen.dart';
import 'sobre_screen.dart';

/// Tela "casca" com a barra de navegação inferior.
/// Guarda o estado dos favoritos, que é compartilhado entre as abas.
class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  final _favoritosService = FavoritosService();
  final _cidadeRepository = CidadeRepository();

  int _abaAtual = 0;
  Set<String> _favoritos = {};

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
  }

  Future<void> _carregarFavoritos() async {
    final ids = await _favoritosService.carregar();
    if (!mounted) return;
    setState(() => _favoritos = ids);
  }

  Future<void> _alternarFavorito(Cidade cidade) async {
    final novos = _favoritosService.alternar(_favoritos, cidade.id);
    setState(() => _favoritos = novos);
    await _favoritosService.salvar(novos);
  }

  void _abrirCidade(Cidade cidade) {
    Navigator.of(context).pushNamed(
      AppRoutes.detalheCidade,
      arguments: DetalheCidadeArgs(
        cidade: cidade,
        favoritaInicialmente: _favoritos.contains(cidade.id),
        onAlternarFavorito: _alternarFavorito,
      ),
    );
  }

  void _irParaAba(int indice) => setState(() => _abaAtual = indice);

  @override
  Widget build(BuildContext context) {
    final telas = <Widget>[
      InicioScreen(
        favoritos: _favoritos,
        onAbrirCidade: _abrirCidade,
        onAlternarFavorito: _alternarFavorito,
      ),
      FavoritosScreen(
        cidades: _cidadeRepository.buscarPorIds(_favoritos),
        onAbrirCidade: _abrirCidade,
        onAlternarFavorito: _alternarFavorito,
        onExplorar: () => _irParaAba(0),
      ),
      const GuiaScreen(),
      const SobreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _abaAtual, children: telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _abaAtual,
        onDestinationSelected: _irParaAba,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primariaClara,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Cidades',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _favoritos.isNotEmpty,
              label: Text('${_favoritos.length}'),
              child: const Icon(Icons.favorite_border),
            ),
            selectedIcon: const Icon(Icons.favorite),
            label: 'Favoritas',
          ),
          const NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Guia',
          ),
          const NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Sobre',
          ),
        ],
      ),
    );
  }
}
