import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../core/estado_carregamento.dart';
import '../models/alerta.dart';
import '../models/cidade.dart';
import '../models/previsao.dart';
import '../repositories/dica_repository.dart';
import '../services/alerta_service.dart';
import '../services/clima_service.dart';
import '../widgets/alerta_card.dart';
import '../widgets/cabecalho_clima.dart';
import '../widgets/estado_carregando.dart';
import '../widgets/estado_erro.dart';
import '../widgets/estado_vazio.dart';
import '../widgets/nivel_risco_banner.dart';
import '../widgets/previsao_dia_card.dart';
import '../widgets/secao_titulo.dart';

/// Parâmetros que a tela de detalhe recebe pela navegação.
class DetalheCidadeArgs {
  final Cidade cidade;
  final bool favoritaInicialmente;
  final Future<void> Function(Cidade cidade) onAlternarFavorito;

  const DetalheCidadeArgs({
    required this.cidade,
    required this.favoritaInicialmente,
    required this.onAlternarFavorito,
  });
}

class DetalheCidadeScreen extends StatefulWidget {
  final DetalheCidadeArgs argumentos;

  const DetalheCidadeScreen({super.key, required this.argumentos});

  @override
  State<DetalheCidadeScreen> createState() => _DetalheCidadeScreenState();
}

class _DetalheCidadeScreenState extends State<DetalheCidadeScreen> {
  final _climaService = ClimaService();
  final _alertaService = AlertaService();
  final _dicaRepository = DicaRepository();

  EstadoCarregamento _estado = EstadoCarregamento.inicial;
  PrevisaoClima? _previsao;
  List<Alerta> _alertas = [];
  String _mensagemErro = '';
  late bool _favorita;

  Cidade get _cidade => widget.argumentos.cidade;

  @override
  void initState() {
    super.initState();
    _favorita = widget.argumentos.favoritaInicialmente;
    // A tela nasce no estado "inicial" e começa a busca logo após o 1º frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _carregar());
  }

  Future<void> _carregar({bool silencioso = false}) async {
    if (!silencioso) {
      setState(() => _estado = EstadoCarregamento.carregando);
    }

    try {
      final previsao = await _climaService.buscarPrevisao(_cidade);
      final alertas = _alertaService.gerarAlertas(previsao);
      if (!mounted) return;
      setState(() {
        _previsao = previsao;
        _alertas = alertas;
        _estado = EstadoCarregamento.sucesso;
      });
    } on ClimaException catch (erro) {
      if (!mounted) return;
      // Se já há dados na tela, não apaga tudo: só avisa.
      if (silencioso && _previsao != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro.mensagem)),
        );
        return;
      }
      setState(() {
        _mensagemErro = erro.mensagem;
        _estado = EstadoCarregamento.erro;
      });
    }
  }

  Future<void> _alternarFavorito() async {
    setState(() => _favorita = !_favorita);
    await widget.argumentos.onAlternarFavorito(_cidade);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(_favorita
            ? '${_cidade.nome} foi adicionada às favoritas'
            : '${_cidade.nome} foi removida das favoritas'),
      ));
  }

  void _abrirOrientacoes(TipoRisco tipo) {
    Navigator.of(context).pushNamed(
      AppRoutes.detalheDica,
      arguments: _dicaRepository.porTipo(tipo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cidade.nome),
        actions: [
          IconButton(
            tooltip: 'Atualizar previsão',
            onPressed: _estado == EstadoCarregamento.carregando
                ? null
                : () => _carregar(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: _favorita
                ? 'Remover das favoritas'
                : 'Adicionar às favoritas',
            onPressed: _alternarFavorito,
            icon: Icon(_favorita ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: _construirCorpo(),
    );
  }

  Widget _construirCorpo() {
    switch (_estado) {
      case EstadoCarregamento.inicial:
        return EstadoVazio(
          icone: Icons.cloud_queue,
          titulo: 'Pronto para consultar',
          mensagem: 'Vamos buscar a previsão de ${_cidade.nome}.',
          textoAcao: 'Buscar agora',
          onAcao: () => _carregar(),
        );
      case EstadoCarregamento.carregando:
        return EstadoCarregando(
          mensagem: 'Buscando a previsão de ${_cidade.nome}...',
        );
      case EstadoCarregamento.erro:
        return EstadoErro(
          mensagem: _mensagemErro,
          onTentarNovamente: () => _carregar(),
        );
      case EstadoCarregamento.sucesso:
        return _construirSucesso(_previsao!);
    }
  }

  Widget _construirSucesso(PrevisaoClima previsao) {
    final nivel = _alertaService.nivelGeral(_alertas);

    return RefreshIndicator(
      color: AppColors.primaria,
      onRefresh: () => _carregar(silencioso: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          CabecalhoClima(cidade: _cidade, atual: previsao.atual),
          const SizedBox(height: 16),
          NivelRiscoBanner(
            nivel: nivel,
            descricao: _alertaService.descreverNivel(nivel),
          ),
          const SecaoTitulo(
            titulo: 'Alertas da semana',
            icone: Icons.notifications_active,
          ),
          if (_alertas.isEmpty)
            const Card(
              color: AppColors.riscoBaixoFundo,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Nenhum alerta para os próximos 7 dias.',
                  style: TextStyle(color: AppColors.riscoBaixo),
                ),
              ),
            )
          else
            ..._alertas.map(
              (alerta) => AlertaCard(
                alerta: alerta,
                onVerOrientacoes: () => _abrirOrientacoes(alerta.tipo),
              ),
            ),
          const SecaoTitulo(
            titulo: 'Próximos 7 dias',
            icone: Icons.date_range,
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: previsao.dias.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, indice) =>
                  PrevisaoDiaCard(dia: previsao.dias[indice]),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Dados meteorológicos: Open-Meteo. Puxe a tela para baixo para atualizar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.textoSuave),
          ),
        ],
      ),
    );
  }
}
