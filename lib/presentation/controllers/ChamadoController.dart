import 'package:flutter/foundation.dart';
import 'package:front_end_flutter_cortex_ia/data/models/chamados/ChamadoCreateModel.dart';
import 'package:front_end_flutter_cortex_ia/data/models/chamados/ChamadoModel.dart';
import 'package:front_end_flutter_cortex_ia/data/services/ChamadoService.dart';

class ChamadoController extends ChangeNotifier {
  final ChamadoService service;

  ChamadoController(this.service);

  // ============================
  // LISTA ORIGINAL DO BACKEND
  // ============================
  List<ChamadoModel> chamados = [];

  // ============================
  // LISTA FILTRADA PARA A TELA
  // ============================
  List<ChamadoModel> chamadosFiltrados = [];

  // ============================
  // ESTADOS
  // ============================
  bool isLoading = false;
  bool isSubmitting = false;

  bool hasError = false;
  String? errorMessage;

  // ============================
  // FILTROS ATUAIS
  // ============================
  String filtroBusca = "";
  String filtroStatus = "Todos";
  String filtroPrioridade = "Todas";
  String filtroCategoria = "Todas";

  // ============================================================
  // LISTAR CHAMADOS
  // ============================================================
  Future<void> listarChamados() async {
    _startLoading();

    try {
      final lista = await service.listarChamados();
      chamados = lista;
      _aplicarTodosFiltros();

      hasError = false;
      errorMessage = null;
    } catch (e, st) {
      if (kDebugMode) debugPrint("❌ Erro ao listar chamados: $e\n$st");

      hasError = true;
      errorMessage = _humanizeError(e);
    } finally {
      _stopLoading();
    }
  }

  // ============================================================
  // CRIAR CHAMADO
  // ============================================================
  Future<ChamadoModel?> criarChamado(ChamadoCreateModel model) async {
    _startSubmitting();

    try {
      final criado = await service.criarChamado(model);

      if (criado != null) {
        chamados.insert(0, criado);
        _aplicarTodosFiltros(); // já filtra após criar
        notifyListeners();
      }

      return criado;
    } catch (e, st) {
      if (kDebugMode) debugPrint("❌ Erro ao criar chamado: $e\n$st");

      hasError = true;
      errorMessage = _humanizeError(e);
      return null;
    } finally {
      _stopSubmitting();
    }
  }

  // ============================================================
  // BUSCA LOCAL
  // ============================================================
  ChamadoModel? buscarChamadoLocal(int id) {
    try {
      return chamados.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // REFRESH
  // ============================================================
  Future<void> refresh() async => listarChamados();

  // ============================================================
  // APLICAÇÃO DE FILTROS
  // ============================================================

  void aplicarFiltroBusca(String valor) {
    filtroBusca = valor.trim().toLowerCase();
    _aplicarTodosFiltros();
  }

  void aplicarFiltroStatus(String valor) {
    filtroStatus = valor;
    _aplicarTodosFiltros();
  }

  void aplicarFiltroPrioridade(String valor) {
    filtroPrioridade = valor;
    _aplicarTodosFiltros();
  }

  void aplicarFiltroCategoria(String valor) {
    filtroCategoria = valor;
    _aplicarTodosFiltros();
  }

  // ============================================================
  // LÓGICA PRINCIPAL DE FILTRAGEM
  // ============================================================
  void _aplicarTodosFiltros() {
    List<ChamadoModel> filtrados = [...chamados];

    // BUSCA POR TÍTULO
    if (filtroBusca.isNotEmpty) {
      filtrados = filtrados
          .where((c) => c.titulo.toLowerCase().contains(filtroBusca))
          .toList();
    }

    // STATUS
    if (filtroStatus != "Todos") {
      filtrados = filtrados
          .where((c) => c.status.toLowerCase() == filtroStatus.toLowerCase())
          .toList();
    }

    // PRIORIDADE
    if (filtroPrioridade != "Todas") {
      filtrados = filtrados
          .where((c) => c.prioridade.toUpperCase() == filtroPrioridade)
          .toList();
    }

    // CATEGORIA
    if (filtroCategoria != "Todas") {
      filtrados = filtrados
          .where((c) => c.categoria.toUpperCase() == filtroCategoria)
          .toList();
    }

    chamadosFiltrados = filtrados;
    notifyListeners();
  }

  // ============================================================
  // ESTADOS INTERNOS
  // ============================================================

  void _startLoading() {
    hasError = false;
    errorMessage = null;
    isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void _startSubmitting() {
    hasError = false;
    errorMessage = null;
    isSubmitting = true;
    notifyListeners();
  }

  void _stopSubmitting() {
    isSubmitting = false;
    notifyListeners();
  }

  // ============================================================
  // HUMANIZAÇÃO DE ERROS
  // ============================================================
  String _humanizeError(dynamic e) {
    final msg = e.toString().toLowerCase();

    if (msg.contains("socketexception") ||
        msg.contains("host lookup") ||
        msg.contains("connection")) {
      return "Não foi possível conectar ao servidor. Verifique se o backend está rodando.";
    }

    if (msg.contains("format") || msg.contains("type")) {
      return "Erro ao interpretar dados recebidos do servidor.";
    }

    if (msg.contains("403") || msg.contains("unauthorized")) {
      return "Acesso não autorizado. Verifique credenciais.";
    }

    return "Ocorreu um erro inesperado. Tente novamente.";
  }
}
