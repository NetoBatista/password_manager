import 'package:flutter/material.dart';
import 'package:password_manager/core/enum/password_strength_enum.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/features/password/component/password_security_component.dart';
import 'package:password_manager/features/password/password_controller.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/shared/component/error_component.dart';
import 'package:password_manager/validator/form_validator.dart';
import 'package:password_manager/extension/translate_extension.dart';

class PasswordPage extends StatefulWidget {
  final DocumentFirestoreModel<PasswordModel>? passwordModel;
  const PasswordPage({
    this.passwordModel,
    super.key,
  });

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late PasswordController _controller;
  final _formKey = GlobalKey<FormState>();

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.validateSecurityPassword(passwordModel.document.password);
      _controller.init();
    });
  }

  @override
  void dispose() {
    _controller.passwordStrength = PasswordStrengthEnum.none;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watchContext();
    var isLoading = _controller.value.isLoading;
    var error = _controller.value.error;

    var textAppBar = passwordModel.id.isEmpty
        ? "new_password".translate()
        : "change_password".translate();
    return Scaffold(
      appBar: AppBar(
        title: Text(textAppBar),
      ),
      body: Form(
        key: _formKey,
        child: BodyDefaultComponent(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              enabled: !isLoading,
              initialValue: passwordModel.document.name,
              maxLength: 100,
              validator: FormValidator.requiredField,
              decoration: InputDecoration(
                labelText: 'name'.translate(),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String value) {
                passwordModel.document.name = value;
              },
            ),
            TextFormField(
              enabled: !isLoading,
              initialValue: passwordModel.document.password,
              obscureText: !_controller.showPassword,
              validator: FormValidator.requiredField,
              onChanged: (String value) {
                passwordModel.document.password = value;
                _controller.validateSecurityPassword(value);
              },
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'password'.translate(),
                counterText: '',
                suffixIcon: IconButton(
                  onPressed: _controller.onChangeShowPassword,
                  icon: _controller.showPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            PasswordSecurityComponent(controller: _controller),
            FilledButton(
              onPressed: isLoading ? null : onClickSubmit,
              child: Text('confirm'.translate()),
            ),
            Visibility(
              visible: passwordModel.id.isNotEmpty,
              child: OutlinedButton(
                onPressed: isLoading ? null : onClickRemove,
                child: Text(
                  'remove'.translate(),
                  style: TextStyle(
                    color: isLoading ? null : Colors.red,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const LinearProgressIndicator(),
            ),
            ErrorComponent(error: error),
          ],
        ),
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
