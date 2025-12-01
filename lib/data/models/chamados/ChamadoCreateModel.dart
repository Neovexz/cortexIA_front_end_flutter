import 'package:front_end_flutter_cortex_ia/presentation/widgets/enum_normalizer.dart';

class ChamadoCreateModel {
  final String titulo;
  final String descricao;
  final String local;
  final String prioridade;
  final String impacto;
  final String categoria;

  ChamadoCreateModel({
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
        "prioridade": normalizeEnum(prioridade),
        "impacto": normalizeEnum(impacto),
        "categoria": normalizeEnum(categoria),
      };
}
