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
        builder: (context, snapshotIsLoadingNotifier, snapshot) {
          return ValueListenableBuilder(
              valueListenable: _controller.passwordFilteredListNotifier,
              builder: (context, snapshotPasswordListNotifier, snapshot) {
                return RefreshIndicator(
                  onRefresh: _controller.getAllPassword,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeader(context),
                        const SizedBox(height: 16),
                        Visibility(
                          visible: snapshotIsLoadingNotifier,
                          child: const LinearProgressIndicator(),
                        ),
                        const SizedBox(height: 8),
                        buildPasswordItems(snapshotPasswordListNotifier),
                      ],
                    ),
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
          var lastItem = index == valuePasswordListNotifier.length - 1;
          var passwordModel = valuePasswordListNotifier.elementAt(index);
          var copiedPassword = _controller.copiedPasswordId == passwordModel.id;
          return Padding(
            padding: EdgeInsets.only(bottom: !lastItem ? 0 : 100),
            child: Card(
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.copiedPasswordId = passwordModel.id;
                      Clipboard.setData(
                        ClipboardData(text: passwordModel.document.password),
                      );
                    });
                  },
                  icon: copiedPassword
                      ? const Icon(Icons.check)
                      : const Icon(Icons.copy_outlined),
                ),
                onTap: () {
                  onClickPassword(context, passwordModel);
                },
                title: Text(
                  passwordModel.document.name,
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
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_outlined),
              hintText: 'search'.i18n(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (String value) {
              _controller.searchFilter = value;
              _controller.applyFilter();
            },
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
