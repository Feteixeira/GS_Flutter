import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/pagina_introducao.dart';

class PaginaIntroducaoView extends StatelessWidget {
  final PaginaIntroducao pagina;

  const PaginaIntroducaoView({super.key, required this.pagina});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              color: AppColors.primariaClara,
              shape: BoxShape.circle,
            ),
            child: Icon(pagina.icone, size: 80, color: AppColors.primaria),
          ),
          const SizedBox(height: 40),
          Text(
            pagina.titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.texto,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            pagina.descricao,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textoSuave,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
