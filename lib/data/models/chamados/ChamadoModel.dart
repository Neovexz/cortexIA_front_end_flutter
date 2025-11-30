class ChamadoModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String local;
  final String prioridade;
  final String impacto;
  final String categoria;
  final String? status;
  final String? criadoEm;

  ChamadoModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.local,
    required this.prioridade,
    required this.impacto,
    required this.categoria,
    this.status,
    this.criadoEm,
  });

  // Para enviar ao backend (criação)
  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descricao": descricao,
        "local": local,
        "prioridade": prioridade,
        "impacto": impacto,
        "categoria": categoria,
        "status": status,
        "criadoEm": criadoEm,
      };

  // Para receber do backend
  factory ChamadoModel.fromJson(Map<String, dynamic> json) {
    return ChamadoModel(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      local: json['local'] ?? '',
      prioridade: json['prioridade'] ?? '',
      impacto: json['impacto'] ?? '',
      categoria: json['categoria'] ?? '',
      status: json['status'],
      criadoEm: json['criadoEm'],
    );
  }
}
