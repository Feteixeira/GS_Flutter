import 'alerta.dart';

class Dica {
  final TipoRisco tipo;
  final String titulo;
  final String resumo;
  final List<String> antes;
  final List<String> durante;
  final List<String> depois;

  const Dica({
    required this.tipo,
    required this.titulo,
    required this.resumo,
    required this.antes,
    required this.durante,
    required this.depois,
  });
}
