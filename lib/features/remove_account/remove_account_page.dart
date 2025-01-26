import 'dart:io';

import 'package:flutter/material.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/features/remove_account/remove_account_controller.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/shared/component/error_component.dart';

class RemoveAccountPage extends StatefulWidget {
  const RemoveAccountPage({super.key});

  @override
  State<RemoveAccountPage> createState() => _RemoveAccountPageState();
}

class _RemoveAccountPageState extends State<RemoveAccountPage> {
  late RemoveAccountController controller;
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
      appBar: AppBar(
        title: Text('remove_account'.translate()),
      ),
      body: BodyDefaultComponent(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(textRemoveAccount()),
          OutlinedButton(
            onPressed: isLoading
                ? null
                : () {
                    controller.removeAccount(context);
                  },
            child: Text(
              'remove'.translate(),
              style: TextStyle(color: isLoading ? null : Colors.red),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          ),
          ErrorComponent(error: error),
        ],
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
