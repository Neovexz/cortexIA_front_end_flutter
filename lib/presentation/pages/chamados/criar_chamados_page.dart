import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/chat_page.dart';
import 'package:provider/provider.dart';

import 'package:front_end_flutter_cortex_ia/presentation/controllers/ChamadoController.dart';
import 'package:front_end_flutter_cortex_ia/data/models/chamados/ChamadoCreateModel.dart';
import 'package:front_end_flutter_cortex_ia/data/models/chamados/ChamadoModel.dart';

// Widgets
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/cards/cards.dart';
import '../../widgets/cabecalho_secao.dart';
import '../../widgets/inputs/campo_formulario.dart';
import '../../widgets/inputs/campo_selecao.dart';

/// ----------------------------------------------------------------
/// MAPEAR IMPACTO → PRIORIDADE AUTOMÁTICA
/// ----------------------------------------------------------------
String calcularPrioridadePorImpacto(String impacto) {
  switch (impacto) {
    case "Nenhum impacto":
      return "BAIXA";
    case "Impacto em 1 pessoa":
      return "MEDIA";
    case "Impacto em um setor":
      return "ALTA";
    case "Impacto na empresa inteira":
      return "CRITICA";
    default:
      return "BAIXA";
  }
}

/// ----------------------------------------------------------------
/// MAPEAR IMPACTO PARA ENUM DO BACK
/// ----------------------------------------------------------------
String mapImpacto(String value) {
  switch (value) {
    case "Nenhum impacto":
      return "NENHUM";
    case "Impacto em 1 pessoa":
      return "UMA_PESSOA";
    case "Impacto em um setor":
      return "UM_SETOR";
    case "Impacto na empresa inteira":
      return "EMPRESA_INTEIRA";
    default:
      return value.toUpperCase();
  }
}

/// ----------------------------------------------------------------
/// CATEGORIAS
/// ----------------------------------------------------------------
String mapCategoria(String value) {
  switch (value) {
    case "Sistema":
      return "SOFTWARE";  

    case "Computador":
      return "HARDWARE";   

    case "Impressoras":
      return "IMPRESSORA";

    case "Email":
      return "EMAIL";

    case "Rede":
      return "REDE";

    case "Acesso":
      return "ACESSO";

    case "Outros":
      return "OUTROS";

    default:
      return "OUTROS";
  }
}


class CriarChamadosPage extends StatefulWidget {
  const CriarChamadosPage({super.key});

  @override
  State<CriarChamadosPage> createState() => _CriarChamadosPageState();
}

class _CriarChamadosPageState extends State<CriarChamadosPage> {
  // Controladores
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final localController = TextEditingController();

  // Seleções
  String? impactoSelecionado;
  String? categoriaSelecionada;

  bool isSubmitting = false;

  final impactos = [
    'Nenhum impacto',
    'Impacto em 1 pessoa',
    'Impacto em um setor',
    'Impacto na empresa inteira',
  ];

  final categorias = [
    'Sistema',
    'Rede',
    'Computador',
    'Email',
    'Impressoras',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ChamadoController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CabecalhoSecao(title: 'Informações do Chamado'),
              const SizedBox(height: 20),

              // CARD PRINCIPAL
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
                      onChanged: (v) =>
                          setState(() => categoriaSelecionada = v),
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
                      hint: 'Explique o problema...',
                      maxLines: 5,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              PrimaryButton(
                text: isSubmitting ? "Enviando..." : "Abrir Chamado",
                type: ButtonType.blue,
                onPressed: isSubmitting
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!_validarCampos()) return;

                        setState(() => isSubmitting = true);

                        // PRIORIDADE DEFINIDA AUTOMATICAMENTE
                        final prioridade =
                            calcularPrioridadePorImpacto(impactoSelecionado!);

                        final model = ChamadoCreateModel(
                          titulo: tituloController.text.trim(),
                          descricao: descricaoController.text.trim(),
                          local: localController.text.trim(),
                          prioridade: prioridade, // <<< automático
                          impacto: mapImpacto(impactoSelecionado!),
                          categoria: mapCategoria(categoriaSelecionada!),
                        );

                        final ChamadoModel? resposta =
                            await controller.criarChamado(model);

                        setState(() => isSubmitting = false);
                        if (!mounted) return;

                        if (resposta != null) {
                          _mostrarSnackSucesso("Chamado criado com sucesso!");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(chamado: resposta),
                            ),
                          );
                        } else {
                          _mostrarSnackErro(
                            "Ocorreu um erro ao criar o chamado.",
                          );
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------
  // VALIDAÇÃO DOS CAMPOS
  // ----------------------------------------------------------------
  bool _validarCampos() {
    if (_vazio(tituloController.text)) {
      return _erro("Informe um título para o chamado.");
    }
    if (impactoSelecionado == null) {
      return _erro("Selecione o impacto.");
    }
    if (categoriaSelecionada == null) {
      return _erro("Selecione a categoria.");
    }
    if (_vazio(localController.text)) {
      return _erro("Informe o local/setor.");
    }
    if (descricaoController.text.trim().length < 5) {
      return _erro("Descreva melhor o problema (mín. 5 caracteres).");
    }
    return true;
  }

  bool _vazio(String? v) => v == null || v.trim().isEmpty;

  bool _erro(String msg) {
    _mostrarSnackErro(msg);
    return false;
  }

  // ----------------------------------------------------------------
  // FEEDBACKS
  // ----------------------------------------------------------------
  void _mostrarSnackErro(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _mostrarSnackSucesso(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
