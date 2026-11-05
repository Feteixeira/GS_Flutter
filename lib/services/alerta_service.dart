import '../core/data_utils.dart';
import '../models/alerta.dart';
import '../models/previsao.dart';

/// Regra de negócio do app: transforma números da previsão em alertas
/// escritos em linguagem simples. Nenhuma tela faz esse cálculo.
class AlertaService {
  static const calorModerado = 32.0;
  static const calorAlto = 35.0;
  static const chuvaModerada = 25.0; // mm no dia
  static const chuvaAlta = 50.0;
  static const ventoModerado = 40.0; // km/h
  static const ventoAlto = 60.0;
  static const uvModerado = 8.0;
  static const uvAlto = 11.0;
  static const frioModerado = 10.0;
  static const frioAlto = 5.0;

  /// Gera no máximo um alerta por tipo de risco: o mais grave da semana
  /// (e, em caso de empate, o mais próximo). Ordena do mais grave ao menos grave.
  List<Alerta> gerarAlertas(PrevisaoClima previsao) {
    final maisGravePorTipo = <TipoRisco, Alerta>{};

    for (final dia in previsao.dias) {
      for (final alerta in _avaliarDia(dia)) {
        final atual = maisGravePorTipo[alerta.tipo];
        if (atual == null || alerta.nivel.index > atual.nivel.index) {
          maisGravePorTipo[alerta.tipo] = alerta;
        }
      }
    }

    final alertas = maisGravePorTipo.values.toList()
      ..sort((a, b) {
        final porNivel = b.nivel.index.compareTo(a.nivel.index);
        return porNivel != 0 ? porNivel : a.data.compareTo(b.data);
      });
    return alertas;
  }

  NivelRisco nivelGeral(List<Alerta> alertas) {
    if (alertas.isEmpty) return NivelRisco.baixo;
    return alertas
        .map((alerta) => alerta.nivel)
        .reduce((a, b) => a.index >= b.index ? a : b);
  }

  String descreverNivel(NivelRisco nivel) => switch (nivel) {
        NivelRisco.baixo =>
          'Nenhum risco relevante previsto para a semana. Siga com os cuidados de sempre.',
        NivelRisco.moderado =>
          'Há condições que pedem atenção nos próximos dias. Veja os alertas abaixo.',
        NivelRisco.alto =>
          'Há risco alto previsto. Leia os alertas e as orientações de proteção.',
      };

  List<Alerta> _avaliarDia(PrevisaoDia dia) {
    final alertas = <Alerta>[];
    final quando = DataUtils.rotuloEmFrase(dia.data);

    final nivelCalor = _nivelAcima(dia.tempMax, calorModerado, calorAlto);
    if (nivelCalor != null) {
      alertas.add(Alerta(
        tipo: TipoRisco.calor,
        nivel: nivelCalor,
        titulo: nivelCalor == NivelRisco.alto ? 'Onda de calor' : 'Calor forte',
        mensagem:
            'Máxima de ${dia.tempMax.round()}°C $quando. Evite o sol entre 10h e 16h, beba água com frequência e fique de olho em idosos, crianças e animais.',
        data: dia.data,
      ));
    }

    final nivelChuva = _nivelAcima(dia.precipitacao, chuvaModerada, chuvaAlta);
    if (nivelChuva != null) {
      alertas.add(Alerta(
        tipo: TipoRisco.chuva,
        nivel: nivelChuva,
        titulo: nivelChuva == NivelRisco.alto
            ? 'Risco de alagamento'
            : 'Chuva forte',
        mensagem:
            'Até ${dia.precipitacao.round()} mm de chuva $quando. Evite áreas que costumam alagar, não atravesse ruas inundadas e acompanhe os avisos da Defesa Civil.',
        data: dia.data,
      ));
    }

    final nivelVento = _nivelAcima(dia.ventoMax, ventoModerado, ventoAlto);
    if (nivelVento != null) {
      alertas.add(Alerta(
        tipo: TipoRisco.vento,
        nivel: nivelVento,
        titulo: nivelVento == NivelRisco.alto ? 'Ventania' : 'Vento forte',
        mensagem:
            'Rajadas de até ${dia.ventoMax.round()} km/h $quando. Fique longe de árvores, placas e fios e recolha objetos soltos.',
        data: dia.data,
      ));
    }

    final nivelUv = _nivelAcima(dia.uvMax, uvModerado, uvAlto);
    if (nivelUv != null) {
      alertas.add(Alerta(
        tipo: TipoRisco.uv,
        nivel: nivelUv,
        titulo: nivelUv == NivelRisco.alto ? 'UV extremo' : 'UV muito alto',
        mensagem:
            'Índice UV ${dia.uvMax.round()} $quando. Use protetor solar, chapéu e óculos e procure sombra no meio do dia.',
        data: dia.data,
      ));
    }

    final nivelFrio = _nivelAbaixo(dia.tempMin, frioModerado, frioAlto);
    if (nivelFrio != null) {
      alertas.add(Alerta(
        tipo: TipoRisco.frio,
        nivel: nivelFrio,
        titulo: nivelFrio == NivelRisco.alto ? 'Frio intenso' : 'Frio',
        mensagem:
            'Mínima de ${dia.tempMin.round()}°C $quando. Agasalhe-se bem e ajude quem está na rua a encontrar abrigo.',
        data: dia.data,
      ));
    }

    return alertas;
  }

  NivelRisco? _nivelAcima(double valor, double moderado, double alto) {
    if (valor >= alto) return NivelRisco.alto;
    if (valor >= moderado) return NivelRisco.moderado;
    return null;
  }

  NivelRisco? _nivelAbaixo(double valor, double moderado, double alto) {
    if (valor <= alto) return NivelRisco.alto;
    if (valor <= moderado) return NivelRisco.moderado;
    return null;
  }
}
