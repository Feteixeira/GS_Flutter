import 'package:flutter/material.dart';

import '../core/risco_visual.dart';
import '../models/alerta.dart';

class NivelChip extends StatelessWidget {
  final NivelRisco nivel;

  const NivelChip({super.key, required this.nivel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: nivel.corFundo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        nivel.rotulo,
        style: TextStyle(
          color: nivel.cor,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
