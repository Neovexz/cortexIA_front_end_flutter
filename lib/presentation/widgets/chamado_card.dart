import 'package:flutter/material.dart';
import '/data/models/chamado_model.dart';

class ChamadoCard extends StatelessWidget {
  final ChamadoModel chamado;

  const ChamadoCard({super.key, required this.chamado});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (chamado.status) {
      case 'Aberto':
        statusColor = Colors.red;
        break;
      case 'Em andamento':
        statusColor = Colors.orange;
        break;
      case 'Resolvido':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(Icons.support_agent, color: statusColor),
        ),
        title: Text(chamado.titulo),
        subtitle: Text('Status: ${chamado.status}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // No futuro abrirá a tela de detalhes do chamado
        },
      ),
    );
  }
}
