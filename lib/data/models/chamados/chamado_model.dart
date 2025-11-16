class ChamadoModel {
  final String titulo;
  final String descricao;
  final String local;
  final String prioridade;
  final String impacto;
  final String categoria;

  ChamadoModel({
    required this.titulo,
    required this.descricao,
    required this.local,
    required this.prioridade,
    required this.impacto,
    required this.categoria,
  });

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "descricao": descricao,
        "local": local,
        "prioridade": prioridade,
        "impacto": impacto,
        "categoria": categoria,
      };
}
