import 'package:flutter/material.dart';
import '/data/models/chamado_model.dart';
import '/data/services/chamado_service.dart';

class DashboardController extends ChangeNotifier {
  final _service = ChamadoService();

  List<ChamadoModel> chamados = [];
  bool isLoading = true;

  Future<void> carregarChamados() async {
    isLoading = true;
    notifyListeners();

    chamados = await _service.fetchChamados();

    isLoading = false;
    notifyListeners();
  }

  // Estatísticas (simples por enquanto)
  int get totalChamados => chamados.length;
  int get abertos => chamados.where((c) => c.status == 'Aberto').length;
  int get andamento => chamados.where((c) => c.status == 'Em andamento').length;
  int get resolvidos => chamados.where((c) => c.status == 'Resolvido').length;
}
