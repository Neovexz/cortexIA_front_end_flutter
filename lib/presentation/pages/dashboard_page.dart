import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/status_card.dart';
import '../widgets/chamado_card.dart';

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
    controller.addListener(() {
      setState(() {}); // atualiza a tela quando o controller muda
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      StatusCard(
                        title: 'Total de Chamados',
                        value: '${controller.totalChamados}',
                        color: Colors.blue,
                      ),
                      StatusCard(
                        title: 'Abertos',
                        value: '${controller.abertos}',
                        color: Colors.red,
                      ),
                      StatusCard(
                        title: 'Em andamento',
                        value: '${controller.andamento}',
                        color: Colors.orange,
                      ),
                      StatusCard(
                        title: 'Resolvidos',
                        value: '${controller.resolvidos}',
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Chamados Recentes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: controller.chamados
                        .map((c) => ChamadoCard(chamado: c))
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
