import 'package:flutter/material.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/cards/cards.dart';
import '../../widgets/inputs/campo_formulario.dart';
import '../../widgets/cabecalho_secao.dart';
import '../../widgets/inputs/campo_selecao.dart';

class CriarChamadosPage extends StatefulWidget {
  const CriarChamadosPage({super.key});

  @override
  State<CriarChamadosPage> createState() => _CriarChamadosPageState();
}

class _CriarChamadosPageState extends State<CriarChamadosPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController localController = TextEditingController();

  String? prioridadeSelecionada;
  String? impactoSelecionado;
  String? categoriaSelecionada;

  final prioridades = ['Baixa', 'Média', 'Alta', 'Crítica'];
  final impactos = [
    'Nenhum impacto',
    'Impacto em 1 pessoa',
    'Impacto em um setor',
    'Impacto na empresa inteira'
  ];
  final categorias = [
    'Acesso',
    'Rede',
    'Hardware',
    'Software',
    'Email',
    'Impressoras'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CabecalhoSecao(title: 'Informações do Chamado'),
            const SizedBox(height: 20),

            AppCard(
              child: Column(
                children: [
                  CampoFormulario(
                    controller: tituloController,
                    label: 'Título do Chamado',
                    hint: 'Ex: Computador não liga',
                  ),
                  const SizedBox(height: 16),

                  CampoSelecao(
                    label: 'Prioridade',
                    value: prioridadeSelecionada,
                    items: prioridades,
                    onChanged: (v) => setState(() => prioridadeSelecionada = v),
                  ),
                  const SizedBox(height: 16),

                  CampoSelecao(
                    label: 'Impacto na Empresa',
                    value: impactoSelecionado,
                    items: impactos,
                    onChanged: (v) => setState(() => impactoSelecionado = v),
                  ),
                  const SizedBox(height: 16),

                  CampoSelecao(
                    label: 'Categoria',
                    value: categoriaSelecionada,
                    items: categorias,
                    onChanged: (v) => setState(() => categoriaSelecionada = v),
                  ),
                  const SizedBox(height: 16),

                  CampoFormulario(
                    controller: localController,
                    label: 'Local / Setor',
                    hint: 'Ex: Financeiro - Sala 3',
                  ),
                  const SizedBox(height: 16),

                  CampoFormulario(
                    controller: descricaoController,
                    label: 'Descrição Detalhada',
                    hint: 'Explique o problema com detalhes...',
                    maxLines: 5,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            PrimaryButton(
              text: 'Abrir Chamado',
              onPressed: () {},
              type: ButtonType.blue,
            )
          ],
        ),
      ),
    );
  }
}