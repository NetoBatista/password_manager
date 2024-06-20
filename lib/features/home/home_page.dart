import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/home/home_controller.dart';

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
        onPressed: onClickPassword,
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
          return Padding(
            padding: EdgeInsets.only(bottom: !lastItem ? 0 : 100),
            child: Card(
              child: ListTile(
                leading: IconButton(
                  onPressed: () => onClickCopyPassword(passwordModel),
                  icon: const Icon(Icons.copy_outlined),
                ),
                onTap: () {
                  onClickPassword(passwordModel: passwordModel);
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

  Future<void> onClickPassword({
    DocumentFirestoreModel<PasswordModel>? passwordModel,
  }) async {
    await context.pushNamed('/password', arguments: passwordModel);
    _controller.getAllPassword();
  }

  void onClickCopyPassword(
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) {
    Clipboard.setData(
      ClipboardData(text: passwordModel.document.password),
    );
    var snackBar = SnackBar(
      content: Text('successfully_copied'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
