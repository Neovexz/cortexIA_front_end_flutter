class ChamadoModel {
  final int id;
  final String titulo;
  final String descricao;
  final String local;
  final String prioridade;
  final String impacto;
  final String categoria;
  final String status;
  final String criadoEm;
  final String atualizadoEm;

  ChamadoModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.local,
    required this.prioridade,
    required this.impacto,
    required this.categoria,
    required this.status,
    required this.criadoEm,
    required this.atualizadoEm,
  });

  factory ChamadoModel.fromJson(Map<String, dynamic> json) => ChamadoModel(
        id: json['id'],
        titulo: json['titulo'],
        descricao: json['descricao'],
        local: json['local'] ?? '',
        prioridade: json['prioridade'],
        impacto: json['impacto'],
        categoria: json['categoria'],
        status: json['status'],
        criadoEm: json['criadoEm'],
        atualizadoEm: json['atualizadoEm'] ?? '',
      );
}
