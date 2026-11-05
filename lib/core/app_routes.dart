import 'package:flutter/material.dart';

import '../models/dica.dart';
import '../screens/detalhe_cidade_screen.dart';
import '../screens/dica_detalhe_screen.dart';
import '../screens/introducao_screen.dart';
import '../screens/principal_screen.dart';
import '../screens/splash_screen.dart';

/// Todas as rotas do app em um só lugar.
/// Rotas com parâmetro recebem os dados por "arguments".
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const introducao = '/introducao';
  static const principal = '/principal';
  static const detalheCidade = '/detalhe-cidade';
  static const detalheDica = '/detalhe-dica';

  static Route<dynamic> gerarRota(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case introducao:
        return MaterialPageRoute(
          builder: (_) => const IntroducaoScreen(),
          settings: settings,
        );
      case principal:
        return MaterialPageRoute(
          builder: (_) => const PrincipalScreen(),
          settings: settings,
        );
      case detalheCidade:
        final argumentos = settings.arguments as DetalheCidadeArgs;
        return MaterialPageRoute(
          builder: (_) => DetalheCidadeScreen(argumentos: argumentos),
          settings: settings,
        );
      case detalheDica:
        final dica = settings.arguments as Dica;
        return MaterialPageRoute(
          builder: (_) => DicaDetalheScreen(dica: dica),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Página não encontrada')),
          ),
        );
    }
  }
}
