import 'package:flutter/material.dart';
import 'package:password_manager/core/enum/password_strength_enum.dart';
import 'package:password_manager/core/util/password_util.dart';
import 'package:password_manager/features/password/password_controller.dart';

class PasswordSecurityComponent extends StatefulWidget {
  final PasswordController controller;
  const PasswordSecurityComponent({
    required this.controller,
    super.key,
  });

  @override
  State<PasswordSecurityComponent> createState() =>
      _PasswordSecurityComponentState();
}

class _PasswordSecurityComponentState extends State<PasswordSecurityComponent> {
  PasswordController get controller => widget.controller;

  double getScore(PasswordStrengthEnum passwordStrengthEnum) {
    if (passwordStrengthEnum == PasswordStrengthEnum.weak) {
      return 1;
    }
    if (passwordStrengthEnum == PasswordStrengthEnum.normal) {
      return 2;
    }
    if (passwordStrengthEnum == PasswordStrengthEnum.strong) {
      return 3;
    }
    return 0;
  }

  Color getColor(
    PasswordStrengthEnum currentProgress,
    PasswordStrengthEnum passwordStrengthEnum,
  ) {
    var score = getScore(currentProgress);
    if (score == 1) {
      if (passwordStrengthEnum == PasswordStrengthEnum.weak) {
        return Colors.red;
      }
    }
    if (score == 2) {
      if (passwordStrengthEnum == PasswordStrengthEnum.weak) {
        return Colors.blue;
      }
      if (passwordStrengthEnum == PasswordStrengthEnum.normal) {
        return Colors.blue;
      }
    }
    if (score == 3) {
      return Colors.green;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder<PasswordStrengthEnum>(
        valueListenable: controller.passwordStrengthNotifier,
        builder: (context, snapshot, _) {
          return Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: 1,
                  color: getColor(snapshot, PasswordStrengthEnum.weak),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: 1,
                  color: getColor(snapshot, PasswordStrengthEnum.normal),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: 1,
                  color: getColor(snapshot, PasswordStrengthEnum.strong),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                PasswordUtil.translate(snapshot),
                style: TextStyle(
                  color: getColor(snapshot, snapshot),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
