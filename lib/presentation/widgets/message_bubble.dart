import 'package:flutter/material.dart';
import '../../../data/models/chamados/MessageModel.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final String autorUpper = message.autor.toUpperCase();
    final bool isMe = autorUpper == "USER";
    final bool isSystem = autorUpper == "SYSTEM";
    final bool isIA = autorUpper == "IA" || autorUpper == "AI";
    final bool isTecnico = autorUpper == "TECNICO";

    final bg = isMe
        ? const Color(0xFF2979FF)
        : isSystem
            ? Colors.grey.shade200
            : isTecnico
                ? Colors.orange.shade50
                : isIA
                    ? Colors.green.shade50
                    : const Color(0xFFF1F3F6);

    final textColor = isMe ? Colors.white : const Color(0xFF1E1E1E);

    final bool isAssignment = message.conteudo.toLowerCase().contains("encaminhei") ||
        message.conteudo.toLowerCase().contains("encaminhado") ||
        message.conteudo.toLowerCase().contains("encaminhar");

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: 1,
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (isAssignment)
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.notifications_active_outlined, size: 16),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "Seu chamado foi encaminhado para um técnico. O técnico vai atender por aqui.",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (message.attachmentUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            message.attachmentUrl!,
                            width: 240,
                            fit: BoxFit.cover,
                          ),
                        ),

                      if (message.attachmentUrl != null)
                        const SizedBox(height: 8),

                      Text(
                        message.conteudo,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${message.criadoEm.hour.toString().padLeft(2, '0')}:${message.criadoEm.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
