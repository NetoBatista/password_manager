import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/remove_account/remove_account_controller.dart';

class RemoveAccountPage extends StatefulWidget {
  const RemoveAccountPage({super.key});

  @override
  State<RemoveAccountPage> createState() => _RemoveAccountPageState();
}

class _RemoveAccountPageState extends State<RemoveAccountPage> {
  final _controller = RemoveAccountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: _controller.isLoadingNotifier,
            builder: (context, valueIsLoadingNotifier, snapshot) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: context.pop,
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        Text('remove_account'.i18n())
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(textRemoveAccount()),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: valueIsLoadingNotifier
                          ? null
                          : () {
                              _controller.removeAccount(context);
                            },
                      child: Text(
                        'remove'.i18n(),
                        style: TextStyle(
                            color: valueIsLoadingNotifier ? null : Colors.red),
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
                      valueListenable: _controller.messageAlertNotifier,
                      builder: (context, valueMessageAlertNotifier, snapshot) {
                        return Visibility(
                          visible: valueMessageAlertNotifier.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  valueMessageAlertNotifier,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  String textRemoveAccount() {
    if (Platform.localeName == "pt_BR") {
      return """
  Tem certeza que deseja remover a sua conta?

  Todas as senhas e dados da sua conta serão removidos e ao continuar esta ação não pode ser desfeita.
""";
    }
    return """
  Are you sure you want to remove your account?

  All passwords and account data will be removed and continuing this action cannot be undone.
""";
  }
}
