import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/contato_emergencia.dart';

class ContatoEmergenciaCard extends StatelessWidget {
  final ContatoEmergencia contato;
  final VoidCallback onTap;

  const ContatoEmergenciaCard({
    super.key,
    required this.contato,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.riscoAltoFundo,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          child: Column(
            children: [
              Text(
                contato.numero,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.riscoAlto,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                contato.nome,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: AppColors.texto),
              ),
              const SizedBox(height: 6),
              const Icon(Icons.copy, size: 16, color: AppColors.textoSuave),
            ],
          ),
        ),
      ),
    );
  }
}
