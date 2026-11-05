import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class EstadoVazio extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String mensagem;
  final String? textoAcao;
  final VoidCallback? onAcao;

  const EstadoVazio({
    super.key,
    required this.icone,
    required this.titulo,
    required this.mensagem,
    this.textoAcao,
    this.onAcao,
  });

  @override
  Widget build(BuildContext context) {
    final temAcao = textoAcao != null && onAcao != null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 64, color: AppColors.primariaMedia),
            const SizedBox(height: 16),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.texto,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textoSuave, height: 1.4),
            ),
            if (temAcao) ...[
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onAcao, child: Text(textoAcao!)),
            ],
          ],
        ),
      ),
    );
  }
}
