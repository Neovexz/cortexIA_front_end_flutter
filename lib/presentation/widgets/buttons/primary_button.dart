import 'package:flutter/material.dart';

enum ButtonType {
  gradient,
  blue,
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.gradient, // padrão
  });

  @override
  Widget build(BuildContext context) {
    // Escolhe o estilo de acordo com o type
    final bool isGradient = type == ButtonType.gradient;

    // Gradiente oficial CortexIA
    final gradientDecoration = BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFFF6D00),
          Color(0xFFD500F9),
          Color(0xFF2979FF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );

    // Estilo azul sólido oficial
    final solidDecoration = BoxDecoration(
      color: const Color(0xFF2979FF),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: isGradient ? gradientDecoration : solidDecoration,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
