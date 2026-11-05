/// Utilitários de texto usados na busca (ignora acentos e maiúsculas).
class TextoUtils {
  TextoUtils._();

  static const _comAcento =
      'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
  static const _semAcento =
      'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';

  static String normalizar(String texto) {
    final buffer = StringBuffer();
    for (final caractere in texto.split('')) {
      final indice = _comAcento.indexOf(caractere);
      buffer.write(indice >= 0 ? _semAcento[indice] : caractere);
    }
    return buffer.toString().toLowerCase().trim();
  }
}
