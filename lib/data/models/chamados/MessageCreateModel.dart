class MessageCreateModel {
  final String conteudo;
  final String autor;

  MessageCreateModel({required this.conteudo, required this.autor});

  Map<String, dynamic> toJson() => {
        "conteudo": conteudo,
        "autor": autor,
      };
}
