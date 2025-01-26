import 'package:flutter/material.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/features/new_account/new_account_controller.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/shared/component/error_component.dart';
import 'package:password_manager/validator/form_validator.dart';
import 'package:password_manager/extension/translate_extension.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({
    super.key,
  });

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  late NewAccountController controller;
  final _accountModel = AccountModel(
    emailAddress: '',
    password: '',
  );
  final _formKey = GlobalKey<FormState>();

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

    return Scaffold(
      appBar: AppBar(title: Text('register'.translate())),
      body: Form(
        key: _formKey,
        child: BodyDefaultComponent(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              enabled: !isLoading,
              initialValue: _accountModel.emailAddress,
              maxLength: 100,
              validator: FormValidator.requiredField,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: 'email_address'.translate(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                _accountModel.emailAddress = value ?? '';
              },
            ),
            TextFormField(
              enabled: !isLoading,
              initialValue: _accountModel.password,
              obscureText: true,
              maxLength: 100,
              validator: FormValidator.requiredPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password_outlined),
                labelText: 'password'.translate(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                _accountModel.password = value ?? '';
              },
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        controller.submit(context, _accountModel);
                      }
                    },
              child: Text('confirm'.translate()),
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
}
