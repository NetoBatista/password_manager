import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/validator/form_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.lock,
                size: 72,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 36,
                ),
                child: Text(
                  'welcome_to_password_manager'.i18n(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: FormValidator.requiredField,
                        decoration: InputDecoration(
                          hintText: 'email_address'.i18n(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: FormValidator.requiredField,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'password'.i18n(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'forgot_password'.i18n(),
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 16, 36, 36),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "sign_in".i18n().toUpperCase(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Text('or_continue_with'.i18n()),
                    ),
                    const Expanded(child: Divider())
                  ],
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'lib/assets/google.png',
                      height: 48,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text('not_a_member'.i18n())),
                    Flexible(
                        child: TextButton(
                      onPressed: () {},
                      child: Text('register_now'.i18n()),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
