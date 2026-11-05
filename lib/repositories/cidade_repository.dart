import '../core/texto_utils.dart';
import '../data/cidades_data.dart';
import '../models/cidade.dart';

/// Acesso aos dados de cidades e regra de filtragem da busca.
class CidadeRepository {
  static const todasRegioes = 'Todas';

  List<Cidade> listarTodas() => cidadesDisponiveis;

  List<String> get regioes => [todasRegioes, ...regioesDisponiveis];

  List<Cidade> buscarPorIds(Set<String> ids) =>
      cidadesDisponiveis.where((cidade) => ids.contains(cidade.id)).toList();

  List<Cidade> filtrar({String termo = '', String regiao = todasRegioes}) {
    final busca = TextoUtils.normalizar(termo);

    return cidadesDisponiveis.where((cidade) {
      final regiaoConfere = regiao == todasRegioes || cidade.regiao == regiao;
      final textoConfere = busca.isEmpty ||
          TextoUtils.normalizar(cidade.nome).contains(busca) ||
          cidade.uf.toLowerCase() == busca;
      return regiaoConfere && textoConfere;
    }).toList();
  }
}
