import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/account_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/login/login_controller.dart';
import 'package:password_manager/features/new_account/new_account_page.dart';
import 'package:password_manager/features/reset_password/reset_password_page.dart';
import 'package:password_manager/validator/form_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  final _formKey = GlobalKey<FormState>();
  final _accountModel = AccountModel(
    emailAddress: '',
    password: '',
  );

  @override
  void initState() {
    super.initState();
    _controller.automaticLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: _controller.isLoadingNotifier,
              builder: (context, valueIsLoadingNotifier, snapshot) {
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
                              enabled: !valueIsLoadingNotifier,
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
                              enabled: !valueIsLoadingNotifier,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: InkWell(
                        onTap: valueIsLoadingNotifier
                            ? null
                            : () {
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
                                      content: const ResetPasswordPage(),
                                    );
                                  },
                                );
                              },
                        child: Text(
                          'forgot_password'.i18n(),
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                      child: ElevatedButton(
                        onPressed: valueIsLoadingNotifier
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _controller.loginUserPassword(
                                      context, _accountModel);
                                }
                              },
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
                    ValueListenableBuilder(
                      valueListenable: _controller.messageAlertNotifier,
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
                      visible: valueIsLoadingNotifier,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 32.0,
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
                              onPressed: valueIsLoadingNotifier
                                  ? null
                                  : () {
                                      _controller.loginWithGoogle(context);
                                    },
                              icon: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(
                                    valueIsLoadingNotifier
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
                              onPressed: valueIsLoadingNotifier
                                  ? null
                                  : () {
                                      _controller.loginAnonymously(context);
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
                              onPressed: valueIsLoadingNotifier
                                  ? null
                                  : () {
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
                                                  icon: const Icon(
                                                      Icons.arrow_back),
                                                ),
                                                Text('register_now'.i18n()),
                                              ],
                                            ),
                                            content: const NewAccountPage(),
                                          );
                                        },
                                      );
                                    },
                              child: Text('register_now'.i18n()),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
