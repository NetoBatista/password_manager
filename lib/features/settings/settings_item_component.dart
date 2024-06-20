import 'package:flutter/material.dart';

class SettingsItemComponent extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Widget leading;
  final void Function()? onTap;
  const SettingsItemComponent({
    required this.title,
    required this.trailing,
    required this.leading,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          leading,
          const SizedBox(width: 16),
          Text(title),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}
