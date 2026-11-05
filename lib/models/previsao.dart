// Models que representam a resposta JSON da API Open-Meteo.
// Cada um sabe se construir a partir do JSON (fromJson).

double _paraDouble(dynamic valor) => valor is num ? valor.toDouble() : 0.0;

int _paraInt(dynamic valor) => valor is num ? valor.toInt() : 0;

dynamic _itemNaPosicao(List<dynamic> lista, int indice) =>
    indice < lista.length ? lista[indice] : null;

class CondicaoAtual {
  final double temperatura;
  final double sensacaoTermica;
  final int umidade;
  final double precipitacao;
  final double vento;
  final int codigoClima;

  const CondicaoAtual({
    required this.temperatura,
    required this.sensacaoTermica,
    required this.umidade,
    required this.precipitacao,
    required this.vento,
    required this.codigoClima,
  });

  factory CondicaoAtual.fromJson(Map<String, dynamic> json) {
    return CondicaoAtual(
      temperatura: _paraDouble(json['temperature_2m']),
      sensacaoTermica: _paraDouble(json['apparent_temperature']),
      umidade: _paraInt(json['relative_humidity_2m']),
      precipitacao: _paraDouble(json['precipitation']),
      vento: _paraDouble(json['wind_speed_10m']),
      codigoClima: _paraInt(json['weather_code']),
    );
  }
}

class PrevisaoDia {
  final DateTime data;
  final int codigoClima;
  final double tempMax;
  final double tempMin;
  final double precipitacao;
  final int probabilidadeChuva;
  final double ventoMax;
  final double uvMax;

  const PrevisaoDia({
    required this.data,
    required this.codigoClima,
    required this.tempMax,
    required this.tempMin,
    required this.precipitacao,
    required this.probabilidadeChuva,
    required this.ventoMax,
    required this.uvMax,
  });
}

class PrevisaoClima {
  final CondicaoAtual atual;
  final List<PrevisaoDia> dias;

  const PrevisaoClima({required this.atual, required this.dias});

  /// A Open-Meteo devolve os dados diários "em colunas":
  /// uma lista de datas, uma lista de máximas, uma de mínimas...
  /// Aqui juntamos tudo "em linhas", um objeto PrevisaoDia por data.
  factory PrevisaoClima.fromJson(Map<String, dynamic> json) {
    final diario = json['daily'] as Map<String, dynamic>;
    final datas = List<String>.from(diario['time'] as List);

    List<dynamic> coluna(String chave) =>
        (diario[chave] as List<dynamic>?) ?? const [];

    final dias = <PrevisaoDia>[];
    for (var i = 0; i < datas.length; i++) {
      dias.add(PrevisaoDia(
        data: DateTime.parse(datas[i]),
        codigoClima: _paraInt(_itemNaPosicao(coluna('weather_code'), i)),
        tempMax: _paraDouble(_itemNaPosicao(coluna('temperature_2m_max'), i)),
        tempMin: _paraDouble(_itemNaPosicao(coluna('temperature_2m_min'), i)),
        precipitacao:
            _paraDouble(_itemNaPosicao(coluna('precipitation_sum'), i)),
        probabilidadeChuva: _paraInt(
            _itemNaPosicao(coluna('precipitation_probability_max'), i)),
        ventoMax:
            _paraDouble(_itemNaPosicao(coluna('wind_speed_10m_max'), i)),
        uvMax: _paraDouble(_itemNaPosicao(coluna('uv_index_max'), i)),
      ));
    }

    return PrevisaoClima(
      atual: CondicaoAtual.fromJson(json['current'] as Map<String, dynamic>),
      dias: dias,
    );
  }
}
