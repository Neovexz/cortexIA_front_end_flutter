import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/widgets/cards/cards.dart';
import '../controllers/dashboardcontroller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = DashboardController();

  @override
  void initState() {
    super.initState();
    controller.carregarChamados();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.8,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _buildBody(),
      ),
    );
  }

  // =====================================================================
  // 🔥 Estado principal
  // =====================================================================
  Widget _buildBody() {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasError) {
      return _erroWidget(
        mensagem: controller.errorMessage ?? "Erro inesperado.",
        onRetry: () => controller.carregarChamados(),
      );
    }

    if (controller.chamados.isEmpty) {
      return _estadoVazio();
    }

    return _conteudoPrincipal();
  }

  // =====================================================================
  // ⭐ Conteúdo completo do dashboard
  // =====================================================================
  Widget _conteudoPrincipal() {
    return RefreshIndicator(
      onRefresh: () => controller.carregarChamados(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCards(),
            const SizedBox(height: 20),
            const Text(
              "Chamados Recentes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _buildChamadosLista(),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // 📊 Cards de Status do Dashboard
  // =====================================================================
  Widget _buildStatusCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StatusCard(
              title: "Total",
              value: controller.totalChamados.toString(),
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatusCard(
              title: "Abertos",
              value: controller.abertos.toString(),
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatusCard(
              title: "Em Andamento",
              value: controller.andamento.toString(),
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatusCard(
              title: "Finalizados",
              value: controller.resolvidos.toString(),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // 📌 Lista de chamados (cards)
  // =====================================================================
  Widget _buildChamadosLista() {
    return Column(
      children: controller.chamados
          .map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ChamadoCard(chamado: c),
            ),
          )
          .toList(),
    );
  }

  // =====================================================================
  // 🌐 Estado vazio
  // =====================================================================
  Widget _estadoVazio() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_rounded, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 18),
            Text(
              "Nenhum chamado encontrado",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Crie um novo chamado para iniciar.",
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // ❌ Erro com opção de recarregar
  // =====================================================================
  Widget _erroWidget({
    required String mensagem,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red.shade400),
            const SizedBox(height: 20),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Tentar novamente"),
            ),
          ],
        ),
      ),
    );
  }
}
