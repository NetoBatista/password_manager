import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/features/reset_password/reset_password_controller.dart';
import 'package:password_manager/validator/form_validator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = ResetPasswordController();
  var _emailAddress = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: ValueListenableBuilder(
          valueListenable: _controller.isLoadingNotifier,
          builder: (context, valueIsLoadingNotifier, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  enabled: !valueIsLoadingNotifier,
                  initialValue: _emailAddress,
                  maxLength: 100,
                  validator: FormValidator.requiredField,
                  decoration: InputDecoration(
                    labelText: 'email_address'.i18n(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _emailAddress = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.submit(_emailAddress);
                    }
                  },
                  child: Text(
                    'confirm'.i18n(),
                  ),
                ),
                Visibility(
                  visible: valueIsLoadingNotifier,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _controller.alertMessageNotifier,
                  builder: (context, valueAlertMessageNotifier, snapshot) {
                    var isSuccess = valueAlertMessageNotifier ==
                        "reset_password_success".i18n();
                    return Visibility(
                      visible: valueAlertMessageNotifier.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            isSuccess
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                  ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                valueAlertMessageNotifier,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color:
                                        isSuccess ? Colors.green : Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
