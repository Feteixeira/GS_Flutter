import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../services/preferencias_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _preferencias = PreferenciasService();

  @override
  void initState() {
    super.initState();
    _decidirProximaTela();
  }

  Future<void> _decidirProximaTela() async {
    final tempoMinimo = Future.delayed(const Duration(seconds: 2));
    final exibirIntroducao = await _preferencias.deveExibirIntroducao();
    await tempoMinimo;

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      exibirIntroducao ? AppRoutes.introducao : AppRoutes.principal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaria,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 150),
            const SizedBox(height: 24),
            const Text(
              'Alerta Cidadão',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'O tempo explicado para quem vive nele',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 48),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                color: AppColors.destaque,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
