import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String error;
  const ErrorComponent({
    required this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: error.isNotEmpty,
      child: Row(
        spacing: 8,
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.red,
          ),
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
