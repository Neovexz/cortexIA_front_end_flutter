class ChamadoModel {
  final int id;
  final String titulo;
  final String status;
  final String descricao;
  final String criadoEm;

  ChamadoModel({
    required this.id,
    required this.titulo,
    required this.status,
    required this.descricao,
    required this.criadoEm,
  });

  // TODO: Quando vier JSON do backend Java
  factory ChamadoModel.fromJson(Map<String, dynamic> json) {
    return ChamadoModel(
      id: json['id'],
      titulo: json['titulo'],
      status: json['status'],
      descricao: json['descricao'],
      criadoEm: json['criadoEm'],
    );
  }
}
