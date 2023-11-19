import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/features/password/password_controller.dart';

class PasswordPage extends StatefulWidget {
  final PasswordModel passwordModel;
  const PasswordPage(this.passwordModel, {super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _controller = PasswordController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: widget.passwordModel.name,
            maxLength: 100,
            decoration: InputDecoration(
              labelText: 'name'.i18n(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder(
            valueListenable: _controller.showPasswordNotifier,
            builder: (context, valueShowPasswordNotifier, snapshot) {
              return TextFormField(
                initialValue: widget.passwordModel.password,
                obscureText: !valueShowPasswordNotifier,
                decoration: InputDecoration(
                  labelText: 'password'.i18n(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.showPasswordNotifier.value =
                          !_controller.showPasswordNotifier.value;
                    },
                    icon: valueShowPasswordNotifier
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => _controller.submit(widget.passwordModel),
            child: Text('confirm'.i18n()),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder(
            valueListenable: _controller.alertMessageNotifier,
            builder: (context, valueAlertMessage, snapshot) {
              return Visibility(
                visible: valueAlertMessage.isNotEmpty,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        valueAlertMessage,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
