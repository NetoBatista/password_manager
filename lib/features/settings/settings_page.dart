import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
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

  @override
  Widget build(BuildContext context) {
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
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          "email@email.com",
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
                          onPressed: () {
                            _controller.changePasswordNotifier.value = true;
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
                      Visibility(
                        visible: valueChangePasswordNotifier,
                        child: Form(
                          key: _formKey,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: TextFormField(
                                    validator: FormValidator.requiredField,
                                    decoration: InputDecoration(
                                      hintText: 'old_password'.i18n(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: TextFormField(
                                    validator: FormValidator.requiredField,
                                    decoration: InputDecoration(
                                      hintText: 'new_password'.i18n(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _controller.changePasswordNotifier
                                                .value = false;
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
                                          onPressed: () {},
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
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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
                onPressed: () {
                  context.pushNamedAndRemoveUntil('/');
                },
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
}
