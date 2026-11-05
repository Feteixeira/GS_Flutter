class Cidade {
  final String id;
  final String nome;
  final String uf;
  final String regiao;
  final double latitude;
  final double longitude;

  const Cidade({
    required this.id,
    required this.nome,
    required this.uf,
    required this.regiao,
    required this.latitude,
    required this.longitude,
  });

  String get nomeCompleto => '$nome, $uf';
}
