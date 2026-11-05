import 'preferencias_service.dart';

/// Regra de favoritar/desfavoritar, separada das telas.
class FavoritosService {
  final PreferenciasService _preferencias;

  FavoritosService({PreferenciasService? preferencias})
      : _preferencias = preferencias ?? PreferenciasService();

  Future<Set<String>> carregar() => _preferencias.carregarFavoritos();

  Future<void> salvar(Set<String> ids) => _preferencias.salvarFavoritos(ids);

  /// Devolve um novo conjunto: remove o id se já existia, adiciona se não.
  Set<String> alternar(Set<String> atuais, String id) {
    final novos = Set<String>.from(atuais);
    if (!novos.remove(id)) novos.add(id);
    return novos;
  }
}
