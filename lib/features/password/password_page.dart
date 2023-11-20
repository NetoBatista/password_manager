import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/features/password/password_controller.dart';
import 'package:password_manager/validator/form_validator.dart';

class PasswordPage extends StatefulWidget {
  final DocumentFirestoreModel<PasswordModel> passwordModel;
  const PasswordPage(this.passwordModel, {super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _controller = PasswordController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller.isLoadingNotifier,
      builder: (context, valueIsLoadingNotifier, snapshot) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  enabled: !valueIsLoadingNotifier,
                  initialValue: widget.passwordModel.document.name,
                  maxLength: 100,
                  validator: FormValidator.requiredField,
                  decoration: InputDecoration(
                    labelText: 'name'.i18n(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (String value) {
                    widget.passwordModel.document.name = value;
                  },
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                  valueListenable: _controller.showPasswordNotifier,
                  builder: (context, valueShowPasswordNotifier, snapshot) {
                    return TextFormField(
                      enabled: !valueIsLoadingNotifier,
                      initialValue: widget.passwordModel.document.password,
                      obscureText: !valueShowPasswordNotifier,
                      validator: FormValidator.requiredField,
                      onChanged: (String value) {
                        widget.passwordModel.document.password = value;
                      },
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
                  onPressed: valueIsLoadingNotifier
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _controller.submit(
                              context,
                              widget.passwordModel,
                            );
                          }
                        },
                  child: Text('confirm'.i18n()),
                ),
                Visibility(
                  visible: widget.passwordModel.id.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: OutlinedButton(
                      onPressed: valueIsLoadingNotifier
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _controller.remove(
                                  context,
                                  widget.passwordModel,
                                );
                              }
                            },
                      child: Text(
                        'remove'.i18n(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: valueIsLoadingNotifier,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
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
          ),
        );
      },
    );
  }
}
