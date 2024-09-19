import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';

class ButtonDefault extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;

  const ButtonDefault({
    super.key,
    required this.text,
    required this.onPressed, 
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        padding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
