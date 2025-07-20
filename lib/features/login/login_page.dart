import 'package:flutter/material.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/features/login/login_controller.dart';
import 'package:password_manager/features/reset_password/reset_password_page.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/shared/component/error_component.dart';
import 'package:password_manager/validator/form_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController controller;
  final _formKey = GlobalKey<FormState>();
  final _accountModel = AccountModel(
    emailAddress: '',
    password: '',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.automaticLogin(context);
    });
  }

  Future<void> onClickLogin() async {
    if (_formKey.currentState!.validate()) {
      controller.loginUserPassword(context, _accountModel);
    }
  }

  void onClickForgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 24),
              Text('forgot_password'.translate()),
              const Spacer(),
              IconButton(
                onPressed: context.pop,
                icon: const Icon(Icons.close_outlined),
              ),
              const SizedBox(width: 8),
            ],
          ),
          content: const ResetPasswordPage(),
        );
      },
    );
  }

  void onClickRegisterNow() {
    context.pushNamed('/new_account');
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watchContext<LoginController>();
    var isLoading = controller.value.isLoading;
    var error = controller.value.error;

    return Scaffold(
      body: Center(
        child: BodyDefaultComponent(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'welcome_to_password_manager'.translate(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  TextFormField(
                    validator: FormValidator.requiredField,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: 'email_address'.translate(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (String value) {
                      _accountModel.emailAddress = value;
                    },
                  ),
                  TextFormField(
                    validator: FormValidator.requiredField,
                    obscureText: true,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_outlined),
                      hintText: 'password'.translate(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (String value) {
                      _accountModel.password = value;
                    },
                  )
                ],
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
                alignment: Alignment.centerRight,
              ),
              onPressed: isLoading ? null : onClickForgotPassword,
              child: Text('forgot_password'.translate()),
            ),
            FilledButton(
              onPressed: isLoading ? null : onClickLogin,
              child: Text(
                "sign_in".translate().toUpperCase(),
              ),
            ),
            ErrorComponent(error: error),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  left: 32,
                  right: 32,
                ),
                child: LinearProgressIndicator(),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text('or_continue_with'.translate()),
                ),
                const Expanded(child: Divider())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: isLoading
                          ? null
                          : () {
                              controller.loginWithGoogle(context);
                            },
                      icon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            isLoading
                                ? 'lib/assets/google_black_white.png'
                                : 'lib/assets/google.png',
                            height: 48,
                          ),
                        ),
                      ),
                    ),
                    const Text('Google'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: isLoading
                          ? null
                          : () {
                              controller.loginAnonymously(context);
                            },
                      icon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.account_box_outlined,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                    Text('no_account'.translate())
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text('not_a_member'.translate())),
                  Flexible(
                    child: TextButton(
                      onPressed: isLoading ? null : onClickRegisterNow,
                      child: Text('register'.translate()),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
