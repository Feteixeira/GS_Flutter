import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/cidade.dart';

class CidadeCard extends StatelessWidget {
  final Cidade cidade;
  final bool favorita;
  final VoidCallback onTap;
  final VoidCallback onFavoritar;

  const CidadeCard({
    super.key,
    required this.cidade,
    required this.favorita,
    required this.onTap,
    required this.onFavoritar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.superficie,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.primariaClara),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primariaClara,
                child: Text(
                  cidade.uf,
                  style: const TextStyle(
                    color: AppColors.primaria,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cidade.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.texto,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Região ${cidade.regiao}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textoSuave,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: favorita
                    ? 'Remover dos favoritos'
                    : 'Adicionar aos favoritos',
                onPressed: onFavoritar,
                icon: Icon(
                  favorita ? Icons.favorite : Icons.favorite_border,
                  color: favorita ? AppColors.riscoAlto : AppColors.textoSuave,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textoSuave),
            ],
          ),
        ),
      ),
    );
  }
}
