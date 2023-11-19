import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/new_account_model.dart';
import 'package:password_manager/features/new_account/new_account_controller.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({super.key});

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final _controller = NewAccountController();
  final _newAccountModel = NewAccountModel(
    emailAddress: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller.isLoadingNotifier,
      builder: (context, valueIsLoadingNotifier, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                enabled: !valueIsLoadingNotifier,
                initialValue: _newAccountModel.emailAddress,
                maxLength: 100,
                decoration: InputDecoration(
                  labelText: 'email_address'.i18n(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (String? value) {
                  _newAccountModel.emailAddress = value ?? '';
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                enabled: !valueIsLoadingNotifier,
                initialValue: _newAccountModel.password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'password'.i18n(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (String? value) {
                  _newAccountModel.password = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: valueIsLoadingNotifier
                    ? null
                    : () => _controller.submit(_newAccountModel),
                child: Text('confirm'.i18n()),
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
        );
      },
    );
  }
}
