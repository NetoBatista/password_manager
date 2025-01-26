import 'package:flutter/material.dart';

class ProgressIndicatorAppbarComponent extends StatelessWidget {
  final bool isVisible;
  const ProgressIndicatorAppbarComponent({
    required this.isVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: const Padding(
        padding: EdgeInsets.only(right: 16),
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
