import '../../models/chamados/chamado_model.dart';

class ChamadoService {
  // TODO: Substituir por chamada real à AP

// class ChamadoService {
//   final String baseUrl = 'http://localhost:8080/api/chamados'; // depois muda para o IP da API

//   Future<List<ChamadoModel>> listarChamados() async {
//     final response = await http.get(Uri.parse(baseUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((e) => ChamadoModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Erro ao carregar chamados: ${response.statusCode}');
//     }
//   }

//   Future<void> criarChamado(Map<String, dynamic> chamadoData) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(chamadoData),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Erro ao criar chamado');
//     }
//   }
// }

  Future<List<ChamadoModel>> fetchChamados() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simula atraso da API
    return [
      ChamadoModel(
        id: 1,
        titulo: 'Erro na conexão com internet',
        status: 'Aberto',
        descricao: 'Usuário relata perda de conexão em horário comercial.',
        criadoEm: '2025-10-28',
      ),
      ChamadoModel(
        id: 2,
        titulo: 'Excel não abre após atualização',
        status: 'Em andamento',
        descricao: 'Problema após instalação da última versão do Office.',
        criadoEm: '2025-10-27',
      ),
      ChamadoModel(
        id: 3,
        titulo: 'Impressora parou de imprimir',
        status: 'Resolvido',
        descricao: 'Reinstalação do driver solucionou o problema.',
        criadoEm: '2025-10-26',
      ),
    ];
  }
}
