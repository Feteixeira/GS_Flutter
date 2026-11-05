import 'package:flutter/material.dart';

import '../models/pagina_introducao.dart';

const List<PaginaIntroducao> paginasIntroducao = [
  PaginaIntroducao(
    icone: Icons.notifications_active,
    titulo: 'Avisos antes do problema',
    descricao:
        'O Alerta Cidadão transforma a previsão do tempo em avisos simples sobre calor extremo, chuva forte, ventania, frio e radiação UV.',
  ),
  PaginaIntroducao(
    icone: Icons.location_city,
    titulo: 'As cidades que importam pra você',
    descricao:
        'Busque cidades, filtre por região e salve como favoritas aquelas onde você mora, trabalha ou tem família.',
  ),
  PaginaIntroducao(
    icone: Icons.health_and_safety,
    titulo: 'Saiba o que fazer',
    descricao:
        'Cada alerta vem com orientações práticas para antes, durante e depois, além dos telefones de emergência.',
  ),
];
