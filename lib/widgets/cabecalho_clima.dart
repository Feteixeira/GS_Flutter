import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/clima_utils.dart';
import '../models/cidade.dart';
import '../models/previsao.dart';
import 'info_item.dart';

class CabecalhoClima extends StatelessWidget {
  final Cidade cidade;
  final CondicaoAtual atual;

  const CabecalhoClima({super.key, required this.cidade, required this.atual});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaria,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Agora em ${cidade.nomeCompleto}',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                ClimaUtils.icone(atual.codigoClima),
                color: AppColors.destaque,
                size: 56,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${atual.temperatura.round()}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ClimaUtils.descricao(atual.codigoClima),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Sensação térmica de ${atual.sensacaoTermica.round()}°C',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoItem(
                icone: Icons.opacity,
                valor: '${atual.umidade}%',
                rotulo: 'Umidade',
              ),
              InfoItem(
                icone: Icons.air,
                valor: '${atual.vento.round()} km/h',
                rotulo: 'Vento',
              ),
              InfoItem(
                icone: Icons.umbrella,
                valor: '${atual.precipitacao.toStringAsFixed(1)} mm',
                rotulo: 'Chuva agora',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
