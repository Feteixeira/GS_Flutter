import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class EstadoCarregando extends StatelessWidget {
  final String mensagem;

  const EstadoCarregando({super.key, this.mensagem = 'Carregando...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primaria),
            const SizedBox(height: 20),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textoSuave, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
