import 'package:flutter/material.dart';

/// Ícone + valor + rótulo empilhados. Usado no cabeçalho do clima.
class InfoItem extends StatelessWidget {
  final IconData icone;
  final String valor;
  final String rotulo;
  final Color cor;

  const InfoItem({
    super.key,
    required this.icone,
    required this.valor,
    required this.rotulo,
    this.cor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, color: cor, size: 22),
        const SizedBox(height: 4),
        Text(
          valor,
          style: TextStyle(color: cor, fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(rotulo, style: TextStyle(color: cor, fontSize: 12)),
      ],
    );
  }
}
