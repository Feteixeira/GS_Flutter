import 'package:shared_preferences/shared_preferences.dart';

/// Toda a persistência local do app passa por aqui (SharedPreferences).
class PreferenciasService {
  static const _chaveIntroducaoOculta = 'introducao_oculta';
  static const _chaveFavoritos = 'cidades_favoritas';

  Future<bool> deveExibirIntroducao() async {
    final preferencias = await SharedPreferences.getInstance();
    final oculta = preferencias.getBool(_chaveIntroducaoOculta) ?? false;
    return !oculta;
  }

  Future<void> salvarIntroducaoOculta(bool oculta) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setBool(_chaveIntroducaoOculta, oculta);
  }

  Future<Set<String>> carregarFavoritos() async {
    final preferencias = await SharedPreferences.getInstance();
    return (preferencias.getStringList(_chaveFavoritos) ?? <String>[]).toSet();
  }

  Future<void> salvarFavoritos(Set<String> ids) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setStringList(_chaveFavoritos, ids.toList());
  }
}
