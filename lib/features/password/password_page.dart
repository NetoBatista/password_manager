import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/enum/password_strength_enum.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/features/password/component/password_security_component.dart';
import 'package:password_manager/features/password/password_controller.dart';
import 'package:password_manager/validator/form_validator.dart';

class PasswordPage extends StatefulWidget {
  final DocumentFirestoreModel<PasswordModel>? passwordModel;
  final PasswordController controller;
  const PasswordPage({
    this.passwordModel,
    required this.controller,
    super.key,
  });

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  DocumentFirestoreModel<PasswordModel> passwordModel = DocumentFirestoreModel(
    document: PasswordModel(
      name: '',
      password: '',
      createdAt: DateTime.now().toUtc(),
    ),
    id: '',
  );

  @override
  void initState() {
    if (widget.passwordModel != null) {
      passwordModel = widget.passwordModel!;
    }
    super.initState();
    _controller.validateSecurityPassword(passwordModel.document.password);
  }

  @override
  void dispose() {
    _controller.passwordStrengthNotifier.value = PasswordStrengthEnum.none;
    _controller.showPasswordNotifier.value = false;
    super.dispose();
  }

  PasswordController get _controller => widget.controller;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textAppBar = passwordModel.id.isEmpty
        ? "new_password".i18n()
        : "change_password".i18n();
    return Scaffold(
      appBar: AppBar(
        title: Text(textAppBar),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.isLoadingNotifier,
        builder: (context, valueIsLoadingNotifier, snapshot) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    enabled: !valueIsLoadingNotifier,
                    initialValue: passwordModel.document.name,
                    maxLength: 100,
                    validator: FormValidator.requiredField,
                    decoration: InputDecoration(
                      labelText: 'name'.i18n(),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (String value) {
                      passwordModel.document.name = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder(
                    valueListenable: _controller.showPasswordNotifier,
                    builder: (context, valueShowPasswordNotifier, snapshot) {
                      return TextFormField(
                        enabled: !valueIsLoadingNotifier,
                        initialValue: passwordModel.document.password,
                        obscureText: !valueShowPasswordNotifier,
                        validator: FormValidator.requiredField,
                        onChanged: (String value) {
                          passwordModel.document.password = value;
                          _controller.validateSecurityPassword(value);
                        },
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: 'password'.i18n(),
                          counterText: '',
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
                  const SizedBox(height: 8),
                  PasswordSecurityComponent(controller: _controller),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: valueIsLoadingNotifier ? null : onClickSubmit,
                    child: Text('confirm'.i18n()),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: passwordModel.id.isNotEmpty,
                    child: OutlinedButton(
                      onPressed: valueIsLoadingNotifier ? null : onClickRemove,
                      child: Text(
                        'remove'.i18n(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: valueIsLoadingNotifier,
                    child: const LinearProgressIndicator(),
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
      ),
    );
  }

  void onClickRemove() {
    if (_formKey.currentState!.validate()) {
      _controller.remove(context, passwordModel);
    }
  }

  void onClickSubmit() {
    if (_formKey.currentState!.validate()) {
      _controller.submit(context, passwordModel);
    }
  }
}
