import 'package:flutter/material.dart';
import '/data/services/chamado_service.dart';
import '/data/models/chamado_model.dart';

class ChamadosController extends ChangeNotifier {
  final ChamadoService _service = ChamadoService();
  bool isLoading = false;
  List<ChamadoModel> chamados = [];

  Future<void> carregarChamados() async {
    try {
      isLoading = true;
      notifyListeners();
      // chamados = await _service.listarChamados();
    } catch (e) {
      debugPrint('Erro: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
