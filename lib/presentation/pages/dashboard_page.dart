import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Suporte Técnico'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
        },
        icon: const Icon(Icons.add),
        label: const Text('Criar Novo Chamado'),
      ),
      body: const Center(
        
      ),
    );
  }
}
