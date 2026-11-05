import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_routes.dart';
import '../data/contatos_data.dart';
import '../models/contato_emergencia.dart';
import '../repositories/dica_repository.dart';
import '../widgets/contato_emergencia_card.dart';
import '../widgets/dica_card.dart';
import '../widgets/secao_titulo.dart';

class GuiaScreen extends StatelessWidget {
  const GuiaScreen({super.key});

  Future<void> _copiarNumero(
    BuildContext context,
    ContatoEmergencia contato,
  ) async {
    await Clipboard.setData(ClipboardData(text: contato.numero));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('Número ${contato.numero} (${contato.nome}) copiado'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final dicas = DicaRepository().listar();

    return Scaffold(
      appBar: AppBar(title: const Text('Guia de proteção')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SecaoTitulo(
            titulo: 'Telefones de emergência',
            icone: Icons.phone_in_talk,
            padding: EdgeInsets.only(bottom: 10),
          ),
          Row(
            children: contatosEmergencia
                .map((contato) => Expanded(
                      child: ContatoEmergenciaCard(
                        contato: contato,
                        onTap: () => _copiarNumero(context, contato),
                      ),
                    ))
                .toList(),
          ),
          const SecaoTitulo(titulo: 'Como se proteger', icone: Icons.menu_book),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dicas.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, indice) => DicaCard(
              dica: dicas[indice],
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.detalheDica,
                arguments: dicas[indice],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
