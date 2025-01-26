import 'package:flutter/material.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/features/reset_password/reset_password_controller.dart';
import 'package:password_manager/shared/component/error_component.dart';
import 'package:password_manager/validator/form_validator.dart';
import 'package:password_manager/extension/translate_extension.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late ResetPasswordController controller;
  var _emailAddress = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watchContext();
    var isLoading = controller.value.isLoading;
    var error = controller.value.error;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            TextFormField(
              enabled: !isLoading,
              initialValue: _emailAddress,
              maxLength: 100,
              validator: FormValidator.requiredField,
              decoration: InputDecoration(
                labelText: 'email_address'.translate(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                _emailAddress = value ?? '';
              },
            ),
            OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.submit(_emailAddress);
                }
              },
              child: Text(
                'confirm'.translate(),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              ),
            ),
            ErrorComponent(error: error),
          ],
        ),
      ),
    );
  }
}
