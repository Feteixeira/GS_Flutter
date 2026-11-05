import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/clima_utils.dart';
import '../core/data_utils.dart';
import '../models/previsao.dart';

class PrevisaoDiaCard extends StatelessWidget {
  final PrevisaoDia dia;

  const PrevisaoDiaCard({super.key, required this.dia});

  @override
  Widget build(BuildContext context) {
    final hoje = DataUtils.ehHoje(dia.data);

    return SizedBox(
      width: 100,
      child: Card(
        color: hoje ? AppColors.primariaClara : AppColors.superficie,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DataUtils.rotuloCurto(dia.data),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.texto,
                ),
              ),
              Icon(
                ClimaUtils.icone(dia.codigoClima),
                color: AppColors.primariaMedia,
                size: 30,
              ),
              Text(
                '${dia.tempMax.round()}° / ${dia.tempMin.round()}°',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.texto,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.water_drop,
                      size: 14, color: AppColors.primariaMedia),
                  const SizedBox(width: 2),
                  Text(
                    '${dia.probabilidadeChuva}%',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textoSuave),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
