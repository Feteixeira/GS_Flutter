import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/cidade.dart';
import '../repositories/cidade_repository.dart';
import '../widgets/cidade_card.dart';
import '../widgets/estado_vazio.dart';

class InicioScreen extends StatefulWidget {
  final Set<String> favoritos;
  final ValueChanged<Cidade> onAbrirCidade;
  final ValueChanged<Cidade> onAlternarFavorito;

  const InicioScreen({
    super.key,
    required this.favoritos,
    required this.onAbrirCidade,
    required this.onAlternarFavorito,
  });

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final _repositorio = CidadeRepository();
  final _buscaController = TextEditingController();

  String _termo = '';
  String _regiao = CidadeRepository.todasRegioes;

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  void _limparBusca() {
    _buscaController.clear();
    setState(() => _termo = '');
  }

  void _limparFiltros() {
    _buscaController.clear();
    setState(() {
      _termo = '';
      _regiao = CidadeRepository.todasRegioes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cidades = _repositorio.filtrar(termo: _termo, regiao: _regiao);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', width: 30, height: 30),
            const SizedBox(width: 10),
            const Text('Alerta Cidadão'),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primaria,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Escolha uma cidade para ver os alertas da semana.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _buscaController,
                  onChanged: (texto) => setState(() => _termo = texto),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Buscar por cidade ou sigla do estado',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _termo.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpar busca',
                            icon: const Icon(Icons.close),
                            onPressed: _limparBusca,
                          ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              children: _repositorio.regioes.map((regiao) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(regiao),
                    selected: _regiao == regiao,
                    selectedColor: AppColors.primariaClara,
                    onSelected: (_) => setState(() => _regiao = regiao),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 6),
            child: Text(
              cidades.length == 1
                  ? '1 cidade encontrada'
                  : '${cidades.length} cidades encontradas',
              style: const TextStyle(color: AppColors.textoSuave, fontSize: 13),
            ),
          ),
          Expanded(
            child: cidades.isEmpty
                ? EstadoVazio(
                    icone: Icons.search_off,
                    titulo: 'Nenhuma cidade encontrada',
                    mensagem:
                        'Tente outro nome ou escolha "Todas" nas regiões.',
                    textoAcao: 'Limpar filtros',
                    onAcao: _limparFiltros,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: cidades.length,
                    itemBuilder: (_, indice) {
                      final cidade = cidades[indice];
                      return CidadeCard(
                        cidade: cidade,
                        favorita: widget.favoritos.contains(cidade.id),
                        onTap: () => widget.onAbrirCidade(cidade),
                        onFavoritar: () => widget.onAlternarFavorito(cidade),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
