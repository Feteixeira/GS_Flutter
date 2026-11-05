import '../data/dicas_data.dart';
import '../models/alerta.dart';
import '../models/dica.dart';

class DicaRepository {
  List<Dica> listar() => dicasPrevencao;

  Dica porTipo(TipoRisco tipo) =>
      dicasPrevencao.firstWhere((dica) => dica.tipo == tipo);
}
