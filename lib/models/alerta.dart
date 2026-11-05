enum TipoRisco { calor, chuva, vento, uv, frio }

/// A ordem importa: quanto maior o índice, mais grave.
enum NivelRisco { baixo, moderado, alto }

class Alerta {
  final TipoRisco tipo;
  final NivelRisco nivel;
  final String titulo;
  final String mensagem;
  final DateTime data;

  const Alerta({
    required this.tipo,
    required this.nivel,
    required this.titulo,
    required this.mensagem,
    required this.data,
  });
}
