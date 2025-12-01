import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/data/models/chamados/ChamadoModel.dart';

/// ============================================================================
/// 🎨 DESIGN TOKENS (define padrão visual global)
/// ============================================================================

class AppThemeTokens {
  static const double radiusSmall = 12;
  static const double radiusMedium = 16;
  static const double radiusLarge = 20;

  static const Color shadowColor = Color(0x11000000);

  static List<BoxShadow> softShadow = [
    const BoxShadow(
      color: Color(0x15000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const TextStyle titleBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1C1C1C),
  );

  static const TextStyle subtitleMuted = TextStyle(
    fontSize: 13,
    color: Color(0xFF5A5A5A),
  );
}

/// ============================================================================
/// 🧱 AppCard (Base Card Premium)
/// ============================================================================

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double borderRadius;
  final Color backgroundColor;
  final bool enableShadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 14),
    this.borderRadius = AppThemeTokens.radiusMedium,
    this.backgroundColor = Colors.white,
    this.enableShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: enableShadow ? AppThemeTokens.softShadow : null,
      ),
      child: child,
    );
  }
}

/// ============================================================================
/// 📊 StatusCard (Dashboard Card Premium)
/// ============================================================================

class StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(18),
      borderRadius: AppThemeTokens.radiusLarge,
      backgroundColor: color,
      enableShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================================
/// 🎫 ChamadoCard (Card Premium nível WhatsApp Business)
/// ============================================================================

class ChamadoCard extends StatelessWidget {
  final ChamadoModel chamado;
  final VoidCallback? onTap;

  const ChamadoCard({
    super.key,
    required this.chamado,
    this.onTap,
  });

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "aberto":
        return Colors.red.shade500;
      case "em_andamento":
      case "em andamento":
        return Colors.orange.shade500;
      case "resolvido":
      case "finalizado":
        return Colors.green.shade600;
      default:
        return Colors.grey.shade500;
    }
  }

  IconData _categoriaIcon(String cat) {
    switch (cat.toLowerCase()) {
      case "hardware":
        return Icons.memory;
      case "software":
        return Icons.apps;
      case "rede":
        return Icons.wifi;
      case "suporte":
        return Icons.support_agent;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(chamado.status);
    final categoriaIcon = _categoriaIcon(chamado.categoria);

    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      borderRadius: AppThemeTokens.radiusLarge,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppThemeTokens.radiusLarge),
        onTap: onTap,
        child: Row(
          children: [
            // ============================================================
            // Avatar com categoria
            // ============================================================
            CircleAvatar(
              radius: 26,
              backgroundColor: statusColor.withOpacity(0.15),
              child: Icon(categoriaIcon, color: statusColor, size: 28),
            ),

            const SizedBox(width: 16),

            // ============================================================
            // Conteúdo principal
            // ============================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chamado.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemeTokens.titleBold,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.flag, size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Prioridade: ${chamado.prioridade}",
                          style: AppThemeTokens.subtitleMuted,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 14, color: statusColor),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Status: ${_formatStatus(chamado.status)}",
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ============================================================
            // Seta estilosa
            // ============================================================
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }

  /// Formata o status para deixar sempre bonito visualmente
  String _formatStatus(String status) {
    return status
        .toLowerCase()
        .replaceAll("_", " ")
        .replaceFirst(status[0], status[0].toUpperCase());
  }
}
