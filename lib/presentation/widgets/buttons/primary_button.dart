import 'package:flutter/material.dart';

enum ButtonType {
  gradient,
  blue,
}

class PrimaryButton extends StatefulWidget {
  final String text;
  final Future<void> Function()? onPressed;
  final ButtonType type;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.gradient,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    if (_isLoading || widget.onPressed == null) return;

    setState(() => _isLoading = true);

    try {
      await widget.onPressed!.call();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isGradient = widget.type == ButtonType.gradient;

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
          offset: Offset(0, 4),
        ),
      ],
    );

    final solidDecoration = BoxDecoration(
      color: const Color(0xFF2979FF),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
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
          onPressed: _isLoading ? null : _handlePress,
          child: _isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.8,
                  ),
                )
              : Text(
                  widget.text,
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
