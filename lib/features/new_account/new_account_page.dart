import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/features/new_account/new_account_controller.dart';
import 'package:password_manager/validator/form_validator.dart';

class NewAccountPage extends StatefulWidget {
  final NewAccountController controller;
  const NewAccountPage({
    required this.controller,
    super.key,
  });

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  NewAccountController get controller => widget.controller;
  final _accountModel = AccountModel(
    emailAddress: '',
    password: '',
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register_now'.i18n())),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder(
            valueListenable: controller.isLoadingNotifier,
            builder: (context, valueIsLoadingNotifier, snapshot) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      enabled: !valueIsLoadingNotifier,
                      initialValue: _accountModel.emailAddress,
                      maxLength: 100,
                      validator: FormValidator.requiredField,
                      decoration: InputDecoration(
                        labelText: 'email_address'.i18n(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        _accountModel.emailAddress = value ?? '';
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      enabled: !valueIsLoadingNotifier,
                      initialValue: _accountModel.password,
                      obscureText: true,
                      maxLength: 100,
                      validator: FormValidator.requiredPassword,
                      decoration: InputDecoration(
                        labelText: 'password'.i18n(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        _accountModel.password = value ?? '';
                      },
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: valueIsLoadingNotifier
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                controller.submit(context, _accountModel);
                              }
                            },
                      child: Text('confirm'.i18n()),
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: valueIsLoadingNotifier,
                      child: const LinearProgressIndicator(),
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.alertMessageNotifier,
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
            },
          ),
        ),
      ),
    );
  }
}
