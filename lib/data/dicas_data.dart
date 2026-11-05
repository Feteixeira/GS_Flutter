import '../models/alerta.dart';
import '../models/dica.dart';

const List<Dica> dicasPrevencao = [
  Dica(
    tipo: TipoRisco.chuva,
    titulo: 'Chuva forte e alagamentos',
    resumo:
        'Muita chuva em pouco tempo pode causar alagamentos, enxurradas e deslizamentos em encostas.',
    antes: [
      'Guarde documentos e remédios em saco plástico, num lugar alto e fácil de pegar.',
      'Não jogue lixo na rua: ele entope bueiros e piora os alagamentos.',
      'Cadastre seu CEP para receber alertas da Defesa Civil por SMS, enviando o CEP para 40199.',
    ],
    durante: [
      'Não atravesse ruas alagadas, nem a pé nem de carro.',
      'Fique longe de córregos, encostas e muros com rachaduras.',
      'Se a água entrar em casa, desligue a energia elétrica.',
    ],
    depois: [
      'Evite contato com a água da enchente, que pode transmitir leptospirose.',
      'Limpe a casa com água sanitária e descarte alimentos que tiveram contato com a água.',
      'Volte para casa somente quando as autoridades liberarem.',
    ],
  ),
  Dica(
    tipo: TipoRisco.calor,
    titulo: 'Calor extremo',
    resumo:
        'Temperaturas muito altas causam desidratação e insolação, principalmente em idosos, crianças e pessoas com doenças crônicas.',
    antes: [
      'Deixe água sempre por perto e programe pausas para se hidratar.',
      'Combine com vizinhos e familiares quem vai visitar idosos que moram sozinhos.',
      'Descubra lugares frescos perto de você, como bibliotecas e centros comunitários.',
    ],
    durante: [
      'Evite o sol entre 10h e 16h.',
      'Use roupas leves e claras, chapéu e protetor solar.',
      'Beba água mesmo sem sede e evite bebidas alcoólicas.',
      'Nunca deixe crianças ou animais dentro de carros fechados.',
    ],
    depois: [
      'Fique atento a tontura, dor de cabeça, enjoo ou confusão mental.',
      'Se alguém passar mal, procure atendimento ou ligue 192 (SAMU).',
    ],
  ),
  Dica(
    tipo: TipoRisco.vento,
    titulo: 'Ventania',
    resumo:
        'Rajadas fortes derrubam árvores, postes e telhados e podem arremessar objetos.',
    antes: [
      'Recolha objetos soltos de varandas e quintais.',
      'Confira telhas e janelas antes da temporada de temporais.',
    ],
    durante: [
      'Não se abrigue debaixo de árvores, placas ou marquises.',
      'Fique longe de fios elétricos caídos.',
      'Se estiver dirigindo, reduza a velocidade e pare em local seguro.',
    ],
    depois: [
      'Não toque em fios caídos, mesmo que pareçam desligados.',
      'Avise a Defesa Civil (199) sobre árvores ou postes caídos.',
    ],
  ),
  Dica(
    tipo: TipoRisco.uv,
    titulo: 'Radiação UV',
    resumo:
        'Índice UV alto aumenta o risco de queimaduras e, com o tempo, de câncer de pele.',
    antes: [
      'Confira o índice UV do dia antes de sair de casa.',
      'Leve protetor solar com FPS 30 ou mais na bolsa ou mochila.',
    ],
    durante: [
      'Reaplique o protetor a cada 2 horas e depois de suar ou nadar.',
      'Use chapéu de aba larga, óculos de sol e roupas que cubram a pele.',
      'Prefira a sombra entre 10h e 16h.',
    ],
    depois: [
      'Hidrate a pele e beba bastante água.',
      'Procure um médico se surgirem bolhas ou manchas que mudam de cor ou tamanho.',
    ],
  ),
  Dica(
    tipo: TipoRisco.frio,
    titulo: 'Frio intenso',
    resumo:
        'Temperaturas baixas agravam doenças respiratórias e colocam em risco quem vive na rua.',
    antes: [
      'Separe agasalhos e cobertores com antecedência.',
      'Mantenha a vacina da gripe em dia.',
    ],
    durante: [
      'Vista roupas em camadas e proteja mãos, pés e cabeça.',
      'Nunca use braseiros ou fogareiros em ambientes fechados.',
      'Ao ver alguém passando frio na rua, acione a assistência social da sua cidade.',
    ],
    depois: [
      'Fique atento a febre e falta de ar, principalmente em crianças e idosos.',
      'Doe os agasalhos que você não usa para campanhas da sua região.',
    ],
  ),
];
