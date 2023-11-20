import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/util/url_util.dart';
import 'package:password_manager/extension/navigation_extension.dart';

class KnowMorePage extends StatefulWidget {
  const KnowMorePage({super.key});

  @override
  State<KnowMorePage> createState() => _KnowMorePageState();
}

class _KnowMorePageState extends State<KnowMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: context.pop,
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Text('know_more'.i18n())
                ],
              ),
              const SizedBox(height: 24),
              Text(
                textKnowMore(),
              ),
              InkWell(
                onTap: () => UrlUtil.openLink(
                  'https://github.com/NetoBatista/password_manager',
                ),
                child: Center(
                  child: Image.asset(
                    'lib/assets/github.png',
                    height: 72,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String textKnowMore() {
    if (Platform.localeName == "pt_BR") {
      return """
  Este aplicativo é de código aberto e está postado no GithHub, sinta-se a vontade para avaliar o código, informar erros ou sugerir novas features.

  Não coletamos nenhum dado sobre a conta ou senhas salvas. Coletamos apenas as mensagens de erros para manutenção do aplicativo.

  Nunca compartilhe a sua senha com ninguém.

  Todos os dados transitados são criptografados, esse projeto utiliza o firebase para buscar e salvar suas senhas. 
  
  Lembre-se de regularmente de trocar as suas senhas, tanto a do login do aplicativo quanto as senhas salvas, para manter sua segurança ainda melhor.
""";
    }
    return """
  This application is open source and posted on GithHub, feel free to rate the code, report bugs or suggest new features.

  We do not collect any account data or saved passwords. We only collect error messages for application maintenance.

  Never share your password with anyone.

  All data transmitted is encrypted, this project uses firebase to search and save your passwords.
  
  Remember to regularly change your passwords, both the application login and your saved passwords, to maintain your security even better.
""";
  }
}
