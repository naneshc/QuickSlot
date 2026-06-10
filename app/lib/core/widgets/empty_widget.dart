import 'package:flutter/material.dart';

class QuickEmptyWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  const QuickEmptyWidget({
    Key? key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_rounded,
    this.buttonLabel,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey[400],
              size: 72,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            if (buttonLabel != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: onButtonPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6366F1),
                  side: const BorderSide(color: Color(0xFF6366F1)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(buttonLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
