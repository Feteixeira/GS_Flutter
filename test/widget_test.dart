import 'package:alerta_cidadao/models/alerta.dart';
import 'package:alerta_cidadao/models/previsao.dart';
import 'package:alerta_cidadao/services/alerta_service.dart';
import 'package:alerta_cidadao/services/favoritos_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Exemplo no mesmo formato que a Open-Meteo devolve.
  final Map<String, dynamic> respostaExemplo = {
    'current': {
      'temperature_2m': 30.5,
      'apparent_temperature': 33.0,
      'relative_humidity_2m': 60,
      'precipitation': 0.0,
      'weather_code': 1,
      'wind_speed_10m': 12.0,
    },
    'daily': {
      'time': ['2026-11-05', '2026-11-06'],
      'weather_code': [1, 95],
      'temperature_2m_max': [36.2, 28.0],
      'temperature_2m_min': [22.0, 19.0],
      'precipitation_sum': [0.0, 60.0],
      'precipitation_probability_max': [10, 95],
      'wind_speed_10m_max': [15.0, 45.0],
      'uv_index_max': [9.0, 4.0],
    },
  };

  test('converte o JSON da API em objetos Dart', () {
    final previsao = PrevisaoClima.fromJson(respostaExemplo);

    expect(previsao.atual.temperatura, 30.5);
    expect(previsao.dias.length, 2);
    expect(previsao.dias[1].precipitacao, 60.0);
    expect(previsao.dias[1].probabilidadeChuva, 95);
  });

  test('gera alertas com o nível certo', () {
    final alertas =
        AlertaService().gerarAlertas(PrevisaoClima.fromJson(respostaExemplo));

    NivelRisco nivelDe(TipoRisco tipo) =>
        alertas.firstWhere((alerta) => alerta.tipo == tipo).nivel;

    expect(nivelDe(TipoRisco.calor), NivelRisco.alto);
    expect(nivelDe(TipoRisco.chuva), NivelRisco.alto);
    expect(nivelDe(TipoRisco.vento), NivelRisco.moderado);
    expect(nivelDe(TipoRisco.uv), NivelRisco.moderado);
    expect(alertas.any((alerta) => alerta.tipo == TipoRisco.frio), isFalse);
    expect(alertas.first.nivel, NivelRisco.alto);
  });

  test('favoritar e desfavoritar alterna o id', () {
    final service = FavoritosService();

    final comSp = service.alternar({}, 'sao-paulo');
    expect(comSp.contains('sao-paulo'), isTrue);

    final semSp = service.alternar(comSp, 'sao-paulo');
    expect(semSp.contains('sao-paulo'), isFalse);
  });
}
