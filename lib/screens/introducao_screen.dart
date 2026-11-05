import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../data/introducao_data.dart';
import '../services/preferencias_service.dart';
import '../widgets/indicador_paginas.dart';
import '../widgets/pagina_introducao_view.dart';

class IntroducaoScreen extends StatefulWidget {
  const IntroducaoScreen({super.key});

  @override
  State<IntroducaoScreen> createState() => _IntroducaoScreenState();
}

class _IntroducaoScreenState extends State<IntroducaoScreen> {
  final _controller = PageController();
  final _preferencias = PreferenciasService();
  final _paginas = paginasIntroducao;

  int _paginaAtual = 0;
  bool _naoMostrarNovamente = false;

  bool get _naPrimeiraPagina => _paginaAtual == 0;
  bool get _naUltimaPagina => _paginaAtual == _paginas.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _avancar() {
    if (_naUltimaPagina) {
      _concluir();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _voltar() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _concluir() async {
    // Salva exatamente o que a pessoa escolheu no checkbox.
    await _preferencias.salvarIntroducaoOculta(_naoMostrarNovamente);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.principal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _concluir,
                child: const Text('Pular'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _paginas.length,
                onPageChanged: (indice) =>
                    setState(() => _paginaAtual = indice),
                itemBuilder: (_, indice) =>
                    PaginaIntroducaoView(pagina: _paginas[indice]),
              ),
            ),
            IndicadorPaginas(total: _paginas.length, atual: _paginaAtual),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _naoMostrarNovamente,
              onChanged: (valor) =>
                  setState(() => _naoMostrarNovamente = valor ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.primaria,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: const Text('Não mostrar novamente'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: _naPrimeiraPagina ? null : _voltar,
                    child: const Text('Voltar'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _avancar,
                    child: Text(_naUltimaPagina ? 'Começar' : 'Avançar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
