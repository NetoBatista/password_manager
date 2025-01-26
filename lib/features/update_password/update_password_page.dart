import 'package:flutter/material.dart';
import 'package:password_manager/core/model/change_password_model.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/features/update_password/update_password_controller.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/shared/component/error_component.dart';
import 'package:password_manager/validator/form_validator.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    super.key,
  });

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  ChangePasswordModel changePasswordModel = ChangePasswordModel(
    oldPassword: '',
    newPassword: '',
  );
  late UpdatePasswordController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init();
    });
  }

  final _formKey = GlobalKey<FormState>();

  void onClickConfirmChangePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      controller.changePassword(
        changePasswordModel.oldPassword,
        changePasswordModel.newPassword,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watchContext();
    var isLoading = controller.value.isLoading;
    var error = controller.value.error;

    return Scaffold(
      appBar: AppBar(title: Text('change_password'.translate())),
      body: Form(
        key: _formKey,
        child: BodyDefaultComponent(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              obscureText: true,
              enabled: !isLoading,
              validator: FormValidator.requiredPassword,
              decoration: InputDecoration(
                hintText: 'old_password'.translate(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (String value) {
                changePasswordModel.oldPassword = value;
              },
              maxLength: 100,
            ),
            TextFormField(
              obscureText: true,
              enabled: !isLoading,
              validator: FormValidator.requiredPassword,
              decoration: InputDecoration(
                hintText: 'new_password'.translate(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (String value) {
                changePasswordModel.newPassword = value;
              },
              maxLength: 100,
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () => onClickConfirmChangePassword(context),
              child: Text(
                'confirm'.translate(),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
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
