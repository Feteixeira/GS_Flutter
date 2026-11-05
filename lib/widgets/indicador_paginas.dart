import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class IndicadorPaginas extends StatelessWidget {
  final int total;
  final int atual;

  const IndicadorPaginas({super.key, required this.total, required this.atual});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (indice) {
        final ativo = indice == atual;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: ativo ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: ativo ? AppColors.primaria : AppColors.primariaClara,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
