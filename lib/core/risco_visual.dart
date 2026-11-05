import 'package:flutter/material.dart';

import '../models/alerta.dart';
import 'app_colors.dart';

/// Aparência (texto, ícone e cor) de cada tipo de risco.
/// Fica separado do model para o model não depender da interface.
extension TipoRiscoVisual on TipoRisco {
  String get rotulo => switch (this) {
        TipoRisco.calor => 'Calor extremo',
        TipoRisco.chuva => 'Chuva forte',
        TipoRisco.vento => 'Ventania',
        TipoRisco.uv => 'Radiação UV',
        TipoRisco.frio => 'Frio intenso',
      };

  IconData get icone => switch (this) {
        TipoRisco.calor => Icons.thermostat,
        TipoRisco.chuva => Icons.water_drop,
        TipoRisco.vento => Icons.air,
        TipoRisco.uv => Icons.wb_sunny,
        TipoRisco.frio => Icons.ac_unit,
      };
}

extension NivelRiscoVisual on NivelRisco {
  String get rotulo => switch (this) {
        NivelRisco.baixo => 'Baixo',
        NivelRisco.moderado => 'Moderado',
        NivelRisco.alto => 'Alto',
      };

  Color get cor => switch (this) {
        NivelRisco.baixo => AppColors.riscoBaixo,
        NivelRisco.moderado => AppColors.riscoModerado,
        NivelRisco.alto => AppColors.riscoAlto,
      };

  Color get corFundo => switch (this) {
        NivelRisco.baixo => AppColors.riscoBaixoFundo,
        NivelRisco.moderado => AppColors.riscoModeradoFundo,
        NivelRisco.alto => AppColors.riscoAltoFundo,
      };

  IconData get icone => switch (this) {
        NivelRisco.baixo => Icons.check_circle,
        NivelRisco.moderado => Icons.warning_amber_rounded,
        NivelRisco.alto => Icons.error,
      };
}
