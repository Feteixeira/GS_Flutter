import 'package:flutter/material.dart';

import 'core/app_colors.dart';
import 'core/app_routes.dart';

class AlertaCidadaoApp extends StatelessWidget {
  const AlertaCidadaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerta Cidadão',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaria,
          primary: AppColors.primaria,
        ),
        scaffoldBackgroundColor: AppColors.fundo,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaria,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaria,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.gerarRota,
    );
  }
}
