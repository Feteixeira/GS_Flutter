import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/risco_visual.dart';
import '../models/dica.dart';

class DicaCard extends StatelessWidget {
  final Dica dica;
  final VoidCallback onTap;

  const DicaCard({super.key, required this.dica, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.superficie,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.primariaClara),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primariaClara,
                child: Icon(dica.tipo.icone, color: AppColors.primaria),
              ),
              const SizedBox(height: 10),
              Text(
                dica.titulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.texto,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  dica.resumo,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textoSuave,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
