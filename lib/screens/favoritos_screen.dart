import 'package:flutter/material.dart';

import '../models/cidade.dart';
import '../widgets/cidade_card.dart';
import '../widgets/estado_vazio.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Cidade> cidades;
  final ValueChanged<Cidade> onAbrirCidade;
  final ValueChanged<Cidade> onAlternarFavorito;
  final VoidCallback onExplorar;

  const FavoritosScreen({
    super.key,
    required this.cidades,
    required this.onAbrirCidade,
    required this.onAlternarFavorito,
    required this.onExplorar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cidades favoritas')),
      body: cidades.isEmpty
          ? EstadoVazio(
              icone: Icons.favorite_border,
              titulo: 'Nenhuma cidade favorita ainda',
              mensagem:
                  'Toque no coração de uma cidade para acompanhá-la por aqui.',
              textoAcao: 'Ver cidades',
              onAcao: onExplorar,
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: cidades.length,
              itemBuilder: (_, indice) {
                final cidade = cidades[indice];
                return CidadeCard(
                  cidade: cidade,
                  favorita: true,
                  onTap: () => onAbrirCidade(cidade),
                  onFavoritar: () => onAlternarFavorito(cidade),
                );
              },
            ),
    );
  }
}
