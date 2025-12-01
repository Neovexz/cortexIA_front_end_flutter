import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/controllers/ChamadoController.dart';
import 'package:front_end_flutter_cortex_ia/presentation/widgets/cards/cards.dart';
import 'package:provider/provider.dart';

import 'package:front_end_flutter_cortex_ia/presentation/pages/chat_page.dart';

class ChamadosPage extends StatefulWidget {
  const ChamadosPage({super.key});

  @override
  State<ChamadosPage> createState() => _ChamadosPageState();
}

class _ChamadosPageState extends State<ChamadosPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ChamadoController>(context, listen: false).listarChamados();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ChamadoController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildFiltros(controller),
                const SizedBox(height: 10),
                Expanded(
                  child: controller.chamadosFiltrados.isEmpty
                      ? const Center(
                          child: Text(
                            "Nenhum chamado encontrado.",
                            style: TextStyle(
                                fontSize: 16, color: Colors.black54),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(14),
                          itemCount: controller.chamadosFiltrados.length,
                          itemBuilder: (context, index) {
                            final chamado =
                                controller.chamadosFiltrados[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ChamadoCard(
                                chamado: chamado,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ChatPage(chamado: chamado),
                                    ),
                                  ).then((_) {
                                    controller.listarChamados();
                                  });
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  // ===========================================================================
  // 🔍 FILTROS INTELIGENTES – UI PROFISSIONAL
  // ===========================================================================
  Widget _buildFiltros(ChamadoController controller) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filtros Inteligentes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 16),

            // 🔍 BUSCA
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar por título...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: controller.aplicarFiltroBusca,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _FiltroDropdown(
                    label: "Status",
                    items: const [
                      "Todos",
                      "aberto",
                      "em_andamento",
                      "finalizado"
                    ],
                    value: controller.filtroStatus,
                    onChanged: controller.aplicarFiltroStatus,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FiltroDropdown(
                    label: "Prioridade",
                    items: const [
                      "Todas",
                      "BAIXA",
                      "MEDIA",
                      "ALTA",
                      "CRITICA",
                    ],
                    value: controller.filtroPrioridade,
                    onChanged: controller.aplicarFiltroPrioridade,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _FiltroDropdown(
              label: "Categoria",
              items: const [
                "Todas",
                "HARDWARE",
                "SOFTWARE",
                "REDE",
                "SISTEMA",
                "OUTROS",
              ],
              value: controller.filtroCategoria,
              onChanged: controller.aplicarFiltroCategoria,
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// DROPDOWN REUTILIZÁVEL
// ===========================================================================
class _FiltroDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String value;
  final ValueChanged<String> onChanged;

  const _FiltroDropdown({
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items: items
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ],
    );
  }
}
