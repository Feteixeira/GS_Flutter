import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cidade.dart';
import '../models/previsao.dart';

/// Erro com mensagem pronta para mostrar ao usuário.
class ClimaException implements Exception {
  final String mensagem;

  const ClimaException(this.mensagem);

  @override
  String toString() => mensagem;
}

/// Consome a API REST pública da Open-Meteo (https://open-meteo.com).
/// Não precisa de chave nem cadastro.
class ClimaService {
  static const _host = 'api.open-meteo.com';
  static const _caminho = '/v1/forecast';
  static const _tempoLimite = Duration(seconds: 12);

  final http.Client _client;

  ClimaService({http.Client? client}) : _client = client ?? http.Client();

  Future<PrevisaoClima> buscarPrevisao(Cidade cidade) async {
    final uri = Uri.https(_host, _caminho, {
      'latitude': cidade.latitude.toString(),
      'longitude': cidade.longitude.toString(),
      'current':
          'temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m',
      'daily':
          'weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max,wind_speed_10m_max,uv_index_max',
      'timezone': 'auto',
      'forecast_days': '7',
    });

    try {
      final resposta = await _client.get(uri).timeout(_tempoLimite);

      if (resposta.statusCode != 200) {
        throw ClimaException(
          'O serviço de previsão respondeu com erro (código ${resposta.statusCode}). Tente de novo em alguns instantes.',
        );
      }

      final json = jsonDecode(resposta.body) as Map<String, dynamic>;
      return PrevisaoClima.fromJson(json);
    } on ClimaException {
      rethrow;
    } on TimeoutException {
      throw const ClimaException(
        'O serviço demorou demais para responder. Confira sua conexão e tente de novo.',
      );
    } on http.ClientException {
      throw const ClimaException(
        'Sem conexão com a internet. Confira o Wi-Fi ou os dados móveis e tente de novo.',
      );
    } on FormatException {
      throw const ClimaException(
        'Os dados recebidos vieram num formato inesperado. Tente de novo.',
      );
    } catch (_) {
      throw const ClimaException(
        'Não foi possível buscar a previsão agora. Confira sua conexão e tente de novo.',
      );
    }
  }
}
