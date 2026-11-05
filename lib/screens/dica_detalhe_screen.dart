import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/risco_visual.dart';
import '../models/dica.dart';

class DicaDetalheScreen extends StatelessWidget {
  final Dica dica;

  const DicaDetalheScreen({super.key, required this.dica});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dica.titulo)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primariaClara,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaria,
                  child: Icon(dica.tipo.icone, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    dica.resumo,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.45,
                      color: AppColors.texto,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SecaoOrientacao(
            titulo: 'Antes',
            icone: Icons.event_note,
            itens: dica.antes,
            abertaInicialmente: true,
          ),
          _SecaoOrientacao(
            titulo: 'Durante',
            icone: Icons.warning_amber_rounded,
            itens: dica.durante,
          ),
          _SecaoOrientacao(
            titulo: 'Depois',
            icone: Icons.check_circle_outline,
            itens: dica.depois,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}

class _SecaoOrientacao extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final List<String> itens;
  final bool abertaInicialmente;

  const _SecaoOrientacao({
    required this.titulo,
    required this.icone,
    required this.itens,
    this.abertaInicialmente = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.superficie,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: abertaInicialmente,
        leading: Icon(icone, color: AppColors.primaria),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        children: itens
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check,
                          size: 18, color: AppColors.riscoBaixo),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(item, style: const TextStyle(height: 1.4)),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
