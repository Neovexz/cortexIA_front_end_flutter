import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/chamados_page.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/main_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/models/chamados/MessageCreateModel.dart';
import '../controllers/ChatController.dart';
import '../widgets/message_bubble.dart';
import '../../data/models/chamados/MessageModel.dart';
import '../../data/models/chamados/ChamadoModel.dart';

class ChatPage extends StatefulWidget {
  final ChamadoModel chamado;

  const ChatPage({super.key, required this.chamado});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ChatController>(context, listen: false)
          .loadMessages(widget.chamado.id);
    });
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 200,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendImage() async {
    final ctl = Provider.of<ChatController>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Galeria"),
                onTap: () async {
                  Navigator.pop(context);

                  final picked = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 60,
                  );

                  if (picked != null) {
                    await ctl.sendImage(
                      widget.chamado.id,
                      File(picked.path),
                      autor: "USER",
                    );
                    await ctl.loadMessages(widget.chamado.id);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Câmera"),
                onTap: () async {
                  Navigator.pop(context);

                  final picked = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 60,
                  );

                  if (picked != null) {
                    await ctl.sendImage(
                      widget.chamado.id,
                      File(picked.path),
                      autor: "USER",
                    );
                    await ctl.loadMessages(widget.chamado.id);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage() async {
    final ctl = Provider.of<ChatController>(context, listen: false);
    final text = _input.text.trim();

    if (text.isEmpty) return;

    _input.clear();

    final created = await ctl.sendMessage(
      widget.chamado.id,
      MessageCreateModel(conteudo: text, autor: "USER"),
    );

    // mostra IA digitando enquanto backend processa
    ctl.showIaTyping();
    await Future.delayed(const Duration(milliseconds: 600));
    await ctl.loadMessages(widget.chamado.id);
    ctl.hideIaTyping();

    _scrollToEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, ctl, _) {
        _scrollToEnd();

        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainPage()),
                  (route) => false, 
                );
              },
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chamado.titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.chamado.status.toString().split('.').last,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: ctl.messages.length,
                  itemBuilder: (_, i) {
                    final msg = ctl.messages[i];

                    final bool showDateHeader = i == 0 ||
                        !_isSameDay(msg.criadoEm, ctl.messages[i - 1].criadoEm);

                    return Column(
                      children: [
                        if (showDateHeader) _dayDivider(msg.criadoEm),
                        MessageBubble(message: msg),
                      ],
                    );
                  },
                ),
              ),
              if (ctl.iaTyping || ctl.tecnicoTyping)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 12),
                  child: _typingIndicator(
                    ctl.iaTyping ? "IA digitando..." : "Técnico digitando...",
                  ),
                ),
              _inputArea(ctl),
            ],
          ),
        );
      },
    );
  }

  Widget _typingIndicator(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black54,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _dayDivider(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "${date.day}/${date.month}/${date.year}",
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _inputArea(ChatController ctl) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo, color: Colors.blue),
            onPressed: _sendImage,
          ),
          Expanded(
            child: TextField(
              controller: _input,
              decoration: InputDecoration(
                hintText: "Digite uma mensagem...",
                filled: true,
                fillColor: const Color(0xFFF1F3F6),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
              ),
              minLines: 1,
              maxLines: 6,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: ctl.sending ? null : _sendMessage,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 24,
              child: ctl.sending
                  ? const Padding(
                      padding: EdgeInsets.all(6),
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
