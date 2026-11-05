import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/risco_visual.dart';
import '../models/alerta.dart';

class NivelRiscoBanner extends StatelessWidget {
  final NivelRisco nivel;
  final String descricao;

  const NivelRiscoBanner({
    super.key,
    required this.nivel,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: nivel.corFundo,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: nivel.cor, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(nivel.icone, color: nivel.cor, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Risco da semana: ${nivel.rotulo.toLowerCase()}',
                  style: TextStyle(
                    color: nivel.cor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descricao,
                  style: const TextStyle(color: AppColors.texto, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
