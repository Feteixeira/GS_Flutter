/// Formatação de datas sem depender de pacotes externos.
class DataUtils {
  DataUtils._();

  static const _diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  static const _diasEmFrase = [
    'na segunda',
    'na terça',
    'na quarta',
    'na quinta',
    'na sexta',
    'no sábado',
    'no domingo',
  ];

  static String diaSemana(DateTime data) => _diasSemana[data.weekday - 1];

  static String diaMes(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes';
  }

  static bool ehHoje(DateTime data) {
    final hoje = DateTime.now();
    return data.year == hoje.year &&
        data.month == hoje.month &&
        data.day == hoje.day;
  }

  /// "Hoje" ou "Qui 06/11".
  static String rotuloCurto(DateTime data) =>
      ehHoje(data) ? 'Hoje' : '${diaSemana(data)} ${diaMes(data)}';

  /// "hoje" ou "no sábado (08/11)", para usar no meio de frases.
  static String rotuloEmFrase(DateTime data) => ehHoje(data)
      ? 'hoje'
      : '${_diasEmFrase[data.weekday - 1]} (${diaMes(data)})';
}
