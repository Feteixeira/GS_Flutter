import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/risco_visual.dart';
import '../models/alerta.dart';
import 'nivel_chip.dart';

class AlertaCard extends StatelessWidget {
  final Alerta alerta;
  final VoidCallback onVerOrientacoes;

  const AlertaCard({
    super.key,
    required this.alerta,
    required this.onVerOrientacoes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.superficie,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: alerta.nivel.corFundo, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: alerta.nivel.corFundo,
              child: Icon(alerta.tipo.icone, color: alerta.nivel.cor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alerta.titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.texto,
                          ),
                        ),
                      ),
                      NivelChip(nivel: alerta.nivel),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    alerta.mensagem,
                    style: const TextStyle(
                      color: AppColors.textoSuave,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: onVerOrientacoes,
                      icon: const Icon(Icons.health_and_safety, size: 18),
                      label: const Text('Como se proteger'),
                    ),
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
