import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/change_password_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/settings/settings_controller.dart';
import 'package:password_manager/validator/form_validator.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = SettingsController();
  final _formKey = GlobalKey<FormState>();
  final _changePasswordModel = ChangePasswordModel(
    newPassword: '',
    oldPassword: '',
  );

  @override
  Widget build(BuildContext context) {
    var user = _controller.getCurrentCredential();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: context.pop,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text('settings'.i18n())
                ],
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          user.email ?? 'no_account'.i18n(),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: _controller.changePasswordNotifier,
                builder: (context, valueChangePasswordNotifier, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: !valueChangePasswordNotifier,
                        child: TextButton(
                          onPressed: !_controller.canChangePassword()
                              ? null
                              : () {
                                  _controller.changePasswordNotifier.value =
                                      true;
                                },
                          child: Row(
                            children: [
                              const Icon(Icons.password_outlined),
                              const SizedBox(width: 16),
                              Text('change_password'.i18n()),
                            ],
                          ),
                        ),
                      ),
                      buildChangePassword(valueChangePasswordNotifier)
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pushNamed('/know_more'),
                child: Row(
                  children: [
                    const Icon(Icons.link_outlined),
                    const SizedBox(width: 16),
                    Text('know_more'.i18n()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pushNamed('/privacy'),
                child: Row(
                  children: [
                    const Icon(Icons.privacy_tip_outlined),
                    const SizedBox(width: 16),
                    Text('privacy'.i18n()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _controller.changeAccount(context),
                child: Row(
                  children: [
                    const Icon(Icons.change_circle_outlined),
                    const SizedBox(width: 16),
                    Text('change_account'.i18n()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChangePassword(bool valueChangePasswordNotifier) {
    return ValueListenableBuilder(
      valueListenable: _controller.isLoadingNotifier,
      builder: (context, valueIsLoadingNotifier, snapshot) {
        return Visibility(
          visible: valueChangePasswordNotifier,
          child: Form(
            key: _formKey,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextFormField(
                      obscureText: true,
                      enabled: !valueIsLoadingNotifier,
                      validator: FormValidator.requiredPassword,
                      decoration: InputDecoration(
                        hintText: 'old_password'.i18n(),
                      ),
                      onChanged: (String value) {
                        _changePasswordModel.oldPassword = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextFormField(
                      obscureText: true,
                      enabled: !valueIsLoadingNotifier,
                      validator: FormValidator.requiredPassword,
                      decoration: InputDecoration(
                        hintText: 'new_password'.i18n(),
                      ),
                      onChanged: (String value) {
                        _changePasswordModel.newPassword = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: valueIsLoadingNotifier
                                ? null
                                : () {
                                    _controller.changePasswordNotifier.value =
                                        false;
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.red,
                            ),
                            child: Text(
                              'cancel'.i18n(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: valueIsLoadingNotifier
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _controller.changePassword(
                                        _changePasswordModel.oldPassword,
                                        _changePasswordModel.newPassword,
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                            ),
                            child: Text(
                              'confirm'.i18n(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: valueIsLoadingNotifier,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _controller.messageAlertNotifier,
                    builder: (context, valueMessageAlertNotifier, snapshot) {
                      var isSuccessMessage = valueMessageAlertNotifier ==
                          'password_changed_successfully'.i18n();
                      return Visibility(
                        visible: valueMessageAlertNotifier.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              isSuccessMessage
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.info_outline,
                                      color: Colors.red,
                                    ),
                              const SizedBox(width: 8),
                              Text(
                                valueMessageAlertNotifier,
                                style: TextStyle(
                                    color: isSuccessMessage
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
