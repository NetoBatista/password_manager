import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/home/home_controller.dart';
import 'package:password_manager/features/password/password_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.getAllPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onClickNewPassword(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.isLoadingNotifier,
        builder: (context, valueIsLoadingNotifier, snapshot) {
          return ValueListenableBuilder(
              valueListenable: _controller.passwordFilteredListNotifier,
              builder: (context, valuePasswordListNotifier, snapshot) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      Visibility(
                        visible: valueIsLoadingNotifier,
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,
                            left: 16,
                            right: 16,
                          ),
                          child: LinearProgressIndicator(),
                        ),
                      ),
                      buildPasswordItems(valuePasswordListNotifier),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Flexible buildPasswordItems(
    List<DocumentFirestoreModel<PasswordModel>> valuePasswordListNotifier,
  ) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: valuePasswordListNotifier.length,
        itemBuilder: (BuildContext context, int index) {
          var lastItem = index == 19;
          var passwordModel = valuePasswordListNotifier.elementAt(index);
          return Padding(
            padding: EdgeInsets.only(bottom: !lastItem ? 0 : 100),
            child: Card(
              child: ListTile(
                onTap: () {
                  onClickPassword(context, passwordModel);
                },
                title: Text(passwordModel.document.name),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.passwordCopiedId = passwordModel.id;
                      Clipboard.setData(
                        ClipboardData(text: passwordModel.document.password),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "successfully_copied".i18n(),
                          ),
                        ),
                      );
                    });
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: _controller.passwordCopiedId == passwordModel.id
                        ? const Icon(Icons.check)
                        : const Icon(Icons.copy_outlined),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_outlined),
                hintText: 'search'.i18n(),
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                _controller.searchFilter = value;
                _controller.applyFilter();
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () => context.pushNamed('/settings'),
          icon: const Icon(
            Icons.settings_outlined,
          ),
        )
      ],
    );
  }

  Future<void> onClickNewPassword(BuildContext context) async {
    var response = await showDialog<DocumentFirestoreModel<PasswordModel>?>(
      context: context,
      barrierDismissible: false,
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
              Text('new_password'.i18n()),
            ],
          ),
          content: PasswordPage(
            DocumentFirestoreModel(
              document: PasswordModel(
                name: '',
                password: '',
                createdAt: DateTime.now().toUtc(),
              ),
              id: '',
            ),
          ),
        );
      },
    );
    if (response != null) {
      var list = List<DocumentFirestoreModel<PasswordModel>>.from(
        _controller.passwordListNotifier.value,
      );
      list.insert(0, response);
      _controller.passwordListNotifier.value = list;
      _controller.applyFilter();
    }
  }

  Future<void> onClickPassword(
    BuildContext context,
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) async {
    var response = await showDialog<DocumentFirestoreModel<PasswordModel>?>(
      context: context,
      barrierDismissible: false,
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
              Text('change_password'.i18n()),
            ],
          ),
          content: PasswordPage(passwordModel),
        );
      },
    );
    if (response == null) {
      return;
    }
    if (response.updated) {
      var list = List<DocumentFirestoreModel<PasswordModel>>.from(
        _controller.passwordListNotifier.value,
      );
      var index = list.indexOf(response);
      var item = list.elementAt(index);
      item.document.name = response.document.name;
      item.document.password = response.document.password;
      _controller.passwordListNotifier.value = list;
    } else {
      var list = List<DocumentFirestoreModel<PasswordModel>>.from(
        _controller.passwordListNotifier.value,
      );
      list.remove(response);
      _controller.passwordListNotifier.value = list;
    }
    _controller.applyFilter();
  }
}
