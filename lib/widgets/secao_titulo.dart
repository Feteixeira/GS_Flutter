import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class SecaoTitulo extends StatelessWidget {
  final String titulo;
  final IconData? icone;
  final EdgeInsetsGeometry padding;

  const SecaoTitulo({
    super.key,
    required this.titulo,
    this.icone,
    this.padding = const EdgeInsets.fromLTRB(0, 24, 0, 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (icone != null) ...[
            Icon(icone, size: 20, color: AppColors.primaria),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.texto,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
