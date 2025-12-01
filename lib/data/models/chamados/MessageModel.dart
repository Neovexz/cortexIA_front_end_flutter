class MessageModel {
  final int id;
  final int chamadoId;
  final String conteudo;
  final String autor;
  final DateTime criadoEm;
  final String? attachmentUrl;

  MessageModel({
    required this.id,
    required this.chamadoId,
    required this.conteudo,
    required this.autor,
    required this.criadoEm,
    this.attachmentUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        chamadoId: json['chamadoId'],
        conteudo: json['conteudo'] ?? '',
        autor: json['autor'] ?? 'USER',
        criadoEm: DateTime.parse(json['criadoEm']),
        attachmentUrl: json['attachmentUrl'],
      );
}
