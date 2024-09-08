import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/login/login_controller.dart';
import 'package:password_manager/features/reset_password/reset_password_controller.dart';
import 'package:password_manager/features/reset_password/reset_password_page.dart';
import 'package:password_manager/validator/form_validator.dart';

class LoginPage extends StatefulWidget {
  final LoginController controller;
  final ResetPasswordController resetController;

  const LoginPage({
    required this.controller,
    required this.resetController,
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController get controller => widget.controller;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
            valueListenable: controller.isLoadingNotifier,
            builder: (context, snapshotIsLoading, snapshot) {
              return Column(
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
                            enabled: !snapshotIsLoading,
                            decoration: InputDecoration(
                              hintText: 'email_address'.i18n(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onChanged: (String value) {
                              _accountModel.emailAddress = value;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            validator: FormValidator.requiredField,
                            obscureText: true,
                            enabled: !snapshotIsLoading,
                            decoration: InputDecoration(
                              hintText: 'password'.i18n(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onChanged: (String value) {
                              _accountModel.password = value;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: TextButton(
                          onPressed:
                              snapshotIsLoading ? null : onClickForgotPassword,
                          child: Text('forgot_password'.i18n()),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 36, 8),
                    child: FilledButton(
                      onPressed: snapshotIsLoading ? null : onClickLogin,
                      child: Text(
                        "sign_in".i18n().toUpperCase(),
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.messageAlertNotifier,
                    builder: (context, valueMessageAlertNotifier, snapshot) {
                      return Visibility(
                        visible: valueMessageAlertNotifier.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 36.0,
                            bottom: 8,
                          ),
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
                  ),
                  Visibility(
                    visible: snapshotIsLoading,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 32,
                        right: 32,
                      ),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: snapshotIsLoading
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
                                  snapshotIsLoading
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
                            onPressed: snapshotIsLoading
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
                          Text('no_account'.i18n())
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: Text('not_a_member'.i18n())),
                        Flexible(
                          child: TextButton(
                            onPressed:
                                snapshotIsLoading ? null : onClickRegisterNow,
                            child: Text('register_now'.i18n()),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
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
          titlePadding: const EdgeInsets.only(
            top: 8,
            left: 8,
          ),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: context.pop,
                icon: const Icon(Icons.arrow_back),
              ),
              Text('forgot_password'.i18n()),
            ],
          ),
          content: ResetPasswordPage(
            controller: widget.resetController,
          ),
        );
      },
    );
  }

  void onClickRegisterNow() {
    context.pushNamed('/new_account');
  }
}
