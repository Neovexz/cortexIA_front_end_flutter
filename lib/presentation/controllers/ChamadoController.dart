import 'package:flutter/material.dart';
import '../../data/services/ChamadoService.dart';
import '../../data/models/chamados/ChamadoModel.dart';

class ChamadosController extends ChangeNotifier {
  final ChamadoService _service = ChamadoService();
  bool isLoading = false;
  List<ChamadoModel> chamados = [];

  Future<void> carregarChamados() async {
    try {
      isLoading = true;
      notifyListeners();
      chamados = await _service.listarChamados();
    } catch (e) {
      debugPrint('Erro: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<ChamadoModel?> criarChamado(ChamadoModel model) async {
    try {
      isLoading = true;
      notifyListeners();

      final chamado = await _service.criarChamado(model);

      return chamado;
    } catch (e) {
      debugPrint("Erro: $e");
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
