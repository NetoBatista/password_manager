import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/model/password_model.dart';
import 'package:password_manager/extension/navigation_extension.dart';
import 'package:password_manager/features/password/password_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: PasswordPage(
                  PasswordModel(
                    name: '',
                    password: '',
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  var lastItem = index == 19;
                  return Padding(
                    padding: EdgeInsets.only(bottom: !lastItem ? 0 : 100),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: PasswordPage(
                                  PasswordModel(
                                    name: '${'password'.i18n()} ${index + 1}',
                                    password: index.toString(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        title: Text('${'password'.i18n()} ${index + 1}'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.copy_outlined),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
