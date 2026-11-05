import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../data/equipe_data.dart';
import '../services/preferencias_service.dart';
import '../widgets/secao_titulo.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  static const _ods = [
    'ODS 3: Saúde e bem-estar',
    'ODS 10: Redução das desigualdades',
    'ODS 11: Cidades sustentáveis',
    'ODS 13: Ação contra a mudança do clima',
  ];

  Future<void> _reativarIntroducao(BuildContext context) async {
    await PreferenciasService().salvarIntroducaoOculta(false);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('A introdução vai aparecer na próxima vez que você abrir o app.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o app')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Center(
            child: Image.asset('assets/images/logo.png', width: 96, height: 96),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Alerta Cidadão',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
          ),
          const Center(
            child: Text(
              'Versão 1.0.0',
              style: TextStyle(color: AppColors.textoSuave),
            ),
          ),
          const SecaoTitulo(titulo: 'Por que existe', icone: Icons.lightbulb),
          const _CartaoTexto(
            texto:
                'Enchentes, ondas de calor e temporais estão mais frequentes, e quem mais sofre costuma ser quem tem menos acesso à informação. '
                'A previsão do tempo existe, mas vem em números técnicos. O Alerta Cidadão traduz esses números em avisos simples, '
                'com orientações práticas do que fazer.',
          ),
          const SecaoTitulo(titulo: 'Objetivos de Desenvolvimento Sustentável', icone: Icons.public),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _ods
                .map((ods) => Chip(
                      label: Text(ods, style: const TextStyle(fontSize: 12)),
                      backgroundColor: AppColors.primariaClara,
                      side: BorderSide.none,
                    ))
                .toList(),
          ),
          const SecaoTitulo(titulo: 'Equipe', icone: Icons.groups),
          Card(
            color: AppColors.superficie,
            elevation: 0,
            child: Column(
              children: equipe
                  .map((integrante) => ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.primariaClara,
                          child: Icon(Icons.person, color: AppColors.primaria),
                        ),
                        title: Text(integrante.nome),
                        subtitle: Text('RM ${integrante.rm}'),
                      ))
                  .toList(),
            ),
          ),
          const SecaoTitulo(titulo: 'Fonte dos dados', icone: Icons.cloud),
          const _CartaoTexto(
            texto:
                'Previsões da API pública Open-Meteo (open-meteo.com), que reúne dados de serviços meteorológicos nacionais.',
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _reativarIntroducao(context),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Mostrar a introdução de novo'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _CartaoTexto extends StatelessWidget {
  final String texto;

  const _CartaoTexto({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.superficie,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(texto, style: const TextStyle(height: 1.5)),
      ),
    );
  }
}
