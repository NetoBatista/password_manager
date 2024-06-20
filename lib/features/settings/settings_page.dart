import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/change_password_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/settings/settings_controller.dart';
import 'package:password_manager/features/settings/settings_item_component.dart';
import 'package:password_manager/validator/form_validator.dart';

class SettingsPage extends StatefulWidget {
  final SettingsController settingsController;
  const SettingsPage({
    required this.settingsController,
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsController get _controller => widget.settingsController;
  final _formKey = GlobalKey<FormState>();
  final _changePasswordModel = ChangePasswordModel(
    newPassword: '',
    oldPassword: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.i18n()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          _controller.emailUserAuthenticated(),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SettingsItemComponent(
                onTap: onClickChangeTheme,
                title: 'theme'.i18n(),
                leading: const Icon(Icons.dark_mode_outlined),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: _controller.changePasswordNotifier,
                builder: (context, snapshotChangePasswordNotifier, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: !snapshotChangePasswordNotifier,
                        child: SettingsItemComponent(
                          onTap: !_controller.canChangePassword()
                              ? null
                              : onTapChangePassword,
                          title: 'change_password'.i18n(),
                          leading: const Icon(Icons.password_outlined),
                          trailing: const Icon(Icons.arrow_forward_rounded),
                        ),
                      ),
                      buildChangePassword(snapshotChangePasswordNotifier)
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              SettingsItemComponent(
                onTap: () => context.pushNamed('/know_more'),
                title: 'know_more'.i18n(),
                leading: const Icon(Icons.link_outlined),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
              const SizedBox(height: 16),
              SettingsItemComponent(
                onTap: () => context.pushNamed('/privacy'),
                title: 'privacy'.i18n(),
                leading: const Icon(Icons.privacy_tip_outlined),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
              const SizedBox(height: 16),
              SettingsItemComponent(
                onTap: () => _controller.changeAccount(context),
                title: 'change_account'.i18n(),
                leading: const Icon(Icons.change_circle_outlined),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
              const SizedBox(height: 16),
              SettingsItemComponent(
                onTap: () => context.pushNamed('/remove_account'),
                title: 'remove_account'.i18n(),
                leading: const Icon(Icons.no_accounts_outlined),
                trailing: const Icon(Icons.arrow_forward_rounded),
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
                          child: OutlinedButton(
                            onPressed: valueIsLoadingNotifier
                                ? null
                                : () {
                                    _controller.changePasswordNotifier.value =
                                        false;
                                  },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: Text(
                              'cancel'.i18n(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton(
                            onPressed: valueIsLoadingNotifier
                                ? null
                                : onClickConfirmChangePassword,
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

  void onClickConfirmChangePassword() {
    if (_formKey.currentState!.validate()) {
      _controller.changePassword(
        _changePasswordModel.oldPassword,
        _changePasswordModel.newPassword,
      );
    }
  }

  void onTapChangePassword() {
    _controller.changePasswordNotifier.value = true;
  }

  void onClickChangeTheme() {
    _controller.loadCurrentTheme();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose_theme'.i18n()),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: Text('cancel'.i18n()),
            ),
            TextButton(
              onPressed: () {
                _controller.onChangeTheme();
                context.pop();
              },
              child: Text('continue'.i18n()),
            ),
          ],
          content: ValueListenableBuilder(
            valueListenable: _controller.themeSelected,
            builder: (context, snapshotTheme, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    value: ThemeMode.system,
                    title: Text('system_mode'.i18n()),
                    groupValue: snapshotTheme,
                    onChanged: (ThemeMode? themeMode) {
                      if (themeMode == null) {
                        return;
                      }
                      _controller.themeSelected.value = themeMode;
                    },
                  ),
                  RadioListTile(
                    value: ThemeMode.dark,
                    title: Text('dark_mode'.i18n()),
                    groupValue: snapshotTheme,
                    onChanged: (ThemeMode? themeMode) {
                      if (themeMode == null) {
                        return;
                      }
                      _controller.themeSelected.value = themeMode;
                    },
                  ),
                  RadioListTile(
                    value: ThemeMode.light,
                    title: Text('light_mode'.i18n()),
                    groupValue: snapshotTheme,
                    onChanged: (ThemeMode? themeMode) {
                      if (themeMode == null) {
                        return;
                      }
                      _controller.themeSelected.value = themeMode;
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
