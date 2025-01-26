import 'package:flutter/material.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/settings/settings_controller.dart';
import 'package:password_manager/features/settings/settings_item_component.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/extension/translate_extension.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.init();
    });
  }

  void onClickChangeTheme() => context.pushNamed('/theme');
  void onClickChangePassword() => context.pushNamed('/change_password');

  @override
  Widget build(BuildContext context) {
    _controller = context.watchContext();

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.translate()),
      ),
      body: BodyDefaultComponent(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 16,
                children: [
                  const Icon(Icons.email_outlined),
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
          SettingsItemComponent(
            onTap: onClickChangeTheme,
            title: 'theme'.translate(),
            leading: const Icon(Icons.dark_mode_outlined),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
          SettingsItemComponent(
            onTap:
                !_controller.canChangePassword() ? null : onClickChangePassword,
            title: 'change_password'.translate(),
            leading: const Icon(Icons.password_outlined),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
          SettingsItemComponent(
            onTap: () => context.pushNamed('/know_more'),
            title: 'know_more'.translate(),
            leading: const Icon(Icons.link_outlined),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
          SettingsItemComponent(
            onTap: () => context.pushNamed('/privacy'),
            title: 'privacy'.translate(),
            leading: const Icon(Icons.privacy_tip_outlined),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
          SettingsItemComponent(
            onTap: () => _controller.changeAccount(context),
            title: 'change_account'.translate(),
            leading: const Icon(Icons.change_circle_outlined),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
          SettingsItemComponent(
            onTap: () => context.pushNamed('/remove_account'),
            title: 'remove_account'.translate(),
            leading: const Icon(Icons.no_accounts_outlined),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
        ],
      ),
    );
  }
}
