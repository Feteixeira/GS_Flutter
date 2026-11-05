import '../models/cidade.dart';

/// Cidades disponíveis no app, com as coordenadas usadas na consulta à API.
const List<Cidade> cidadesDisponiveis = [
  Cidade(id: 'manaus', nome: 'Manaus', uf: 'AM', regiao: 'Norte', latitude: -3.1190, longitude: -60.0217),
  Cidade(id: 'belem', nome: 'Belém', uf: 'PA', regiao: 'Norte', latitude: -1.4558, longitude: -48.4902),
  Cidade(id: 'porto-velho', nome: 'Porto Velho', uf: 'RO', regiao: 'Norte', latitude: -8.7612, longitude: -63.9004),
  Cidade(id: 'salvador', nome: 'Salvador', uf: 'BA', regiao: 'Nordeste', latitude: -12.9777, longitude: -38.5016),
  Cidade(id: 'recife', nome: 'Recife', uf: 'PE', regiao: 'Nordeste', latitude: -8.0476, longitude: -34.8770),
  Cidade(id: 'fortaleza', nome: 'Fortaleza', uf: 'CE', regiao: 'Nordeste', latitude: -3.7319, longitude: -38.5267),
  Cidade(id: 'teresina', nome: 'Teresina', uf: 'PI', regiao: 'Nordeste', latitude: -5.0919, longitude: -42.8034),
  Cidade(id: 'brasilia', nome: 'Brasília', uf: 'DF', regiao: 'Centro-Oeste', latitude: -15.7939, longitude: -47.8828),
  Cidade(id: 'goiania', nome: 'Goiânia', uf: 'GO', regiao: 'Centro-Oeste', latitude: -16.6869, longitude: -49.2648),
  Cidade(id: 'cuiaba', nome: 'Cuiabá', uf: 'MT', regiao: 'Centro-Oeste', latitude: -15.6014, longitude: -56.0979),
  Cidade(id: 'sao-paulo', nome: 'São Paulo', uf: 'SP', regiao: 'Sudeste', latitude: -23.5505, longitude: -46.6333),
  Cidade(id: 'rio-de-janeiro', nome: 'Rio de Janeiro', uf: 'RJ', regiao: 'Sudeste', latitude: -22.9068, longitude: -43.1729),
  Cidade(id: 'belo-horizonte', nome: 'Belo Horizonte', uf: 'MG', regiao: 'Sudeste', latitude: -19.9167, longitude: -43.9345),
  Cidade(id: 'vitoria', nome: 'Vitória', uf: 'ES', regiao: 'Sudeste', latitude: -20.3155, longitude: -40.3128),
  Cidade(id: 'porto-alegre', nome: 'Porto Alegre', uf: 'RS', regiao: 'Sul', latitude: -30.0346, longitude: -51.2177),
  Cidade(id: 'sao-leopoldo', nome: 'São Leopoldo', uf: 'RS', regiao: 'Sul', latitude: -29.7604, longitude: -51.1472),
  Cidade(id: 'curitiba', nome: 'Curitiba', uf: 'PR', regiao: 'Sul', latitude: -25.4284, longitude: -49.2733),
  Cidade(id: 'florianopolis', nome: 'Florianópolis', uf: 'SC', regiao: 'Sul', latitude: -27.5954, longitude: -48.5480),
];

const List<String> regioesDisponiveis = [
  'Norte',
  'Nordeste',
  'Centro-Oeste',
  'Sudeste',
  'Sul',
];
