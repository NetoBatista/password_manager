import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/core/enum/password_strength_enum.dart';
import 'package:password_manager/core/model/document_firestore_model.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/core/util/password_util.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/features/home/home_controller.dart';
import 'package:password_manager/shared/component/body_default_component.dart';
import 'package:password_manager/shared/component/error_component.dart';
import 'package:password_manager/shared/component/progress_indicator_appbar_component.dart';
import 'package:password_manager/shared/component/skeleton_loader_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAllPassword();
    });
  }

  Future<void> onClickPassword({
    DocumentFirestoreModel<PasswordModel>? passwordModel,
  }) async {
    await context.pushNamed('/password', arguments: passwordModel);
    controller.getAllPassword();
  }

  void onClickCopyPassword(
    DocumentFirestoreModel<PasswordModel> passwordModel,
  ) {
    Clipboard.setData(
      ClipboardData(text: passwordModel.document.password),
    );
    var snackBar = SnackBar(
      content: Text('successfully_copied'.translate()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watchContext();
    var isLoading = controller.value.isLoading;
    var error = controller.value.error;
    var passwordList = controller.getPasswordList();

    return Scaffold(
      appBar: AppBar(
        title: Text('password_manager'.translate()),
        actions: [
          ProgressIndicatorAppbarComponent(isVisible: isLoading),
          IconButton(
            onPressed: () => context.pushNamed('/settings'),
            icon: const Icon(
              Icons.settings_outlined,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickPassword,
        child: const Icon(Icons.add),
      ),
      body: BodyDefaultComponent(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_outlined),
              hintText: 'search'.translate(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: controller.setFilter,
          ),
          ErrorComponent(error: error),
          Visibility(
            visible: isLoading,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8);
              },
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: SkeletonLoaderComponent(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: passwordList.length,
            itemBuilder: (BuildContext context, int index) {
              var passwordModel = passwordList.elementAt(index);
              var passwordStrength = PasswordUtil.validatePasswordStrength(
                passwordModel.document.password,
              );
              Color color = Colors.red.shade700;
              if (passwordStrength == PasswordStrengthEnum.normal) {
                color = Colors.blue.shade700;
              } else if (passwordStrength == PasswordStrengthEnum.strong) {
                color = Colors.green.shade700;
              }

              return Card(
                shadowColor: Colors.grey,
                child: InkWell(
                  onTap: () => onClickPassword(passwordModel: passwordModel),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          passwordModel.document.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              'level'.translate(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              ': ',
                            ),
                            Text(
                              PasswordUtil.translate(passwordStrength),
                              style: TextStyle(
                                color: color,
                              ),
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () =>
                                  onClickCopyPassword(passwordModel),
                              icon: const Icon(Icons.copy_outlined),
                              label: Text('copy'.translate()),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
