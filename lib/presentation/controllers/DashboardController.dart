import 'package:flutter/foundation.dart';
import '../../data/models/chamados/ChamadoModel.dart';
import '../../data/services/ChamadoService.dart';

class DashboardController extends ChangeNotifier {
  final ChamadoService _service = ChamadoService();

  // ========= ESTADOS PRINCIPAIS =========
  List<ChamadoModel> chamados = [];

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  // ========= CARREGAR CHAMADOS =========
  Future<void> carregarChamados() async {
    try {
      isLoading = true;
      hasError = false;
      errorMessage = null;
      notifyListeners();

      final lista = await _service.listarChamados();

      chamados = lista;
      hasError = false;
      errorMessage = null;
    } catch (e, st) {
      if (kDebugMode) debugPrint("❌ Erro ao carregar: $e\n$st");

      hasError = true;
      errorMessage = _humanizeError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ========= ESTATÍSTICAS =========
  int get totalChamados => chamados.length;

  int get abertos =>
      chamados.where((c) => c.status.toLowerCase() == "aberto").length;

  int get andamento => chamados
      .where((c) =>
          c.status.toLowerCase() == "em_andamento" ||
          c.status.toLowerCase() == "em andamento")
      .length;

  int get resolvidos => chamados
      .where((c) =>
          c.status.toLowerCase() == "resolvido" ||
          c.status.toLowerCase() == "finalizado")
      .length;

  // ========= REFRESH =========
  Future<void> refresh() async => carregarChamados();

  // ========= HUMANIZADOR DE ERROS =========
  String _humanizeError(dynamic e) {
    final msg = e.toString().toLowerCase();

    if (msg.contains("socketexception") ||
        msg.contains("failed host lookup") ||
        msg.contains("connection refused")) {
      return "Não foi possível conectar ao servidor. Verifique se o backend está rodando.";
    }

    if (msg.contains("timeout")) {
      return "O servidor demorou para responder.";
    }

    if (msg.contains("403") || msg.contains("unauthorized")) {
      return "Acesso negado.";
    }

    return "Erro inesperado ao carregar dados.";
  }
}
