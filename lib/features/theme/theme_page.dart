import 'package:flutter/material.dart';
import 'package:password_manager/extension/context_extension.dart';
import 'package:password_manager/extension/translate_extension.dart';
import 'package:password_manager/features/theme/theme_controller.dart';
import 'package:password_manager/shared/component/body_default_component.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  late ThemeController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watchContext();

    return Scaffold(
      appBar: AppBar(
        title: Text('theme'.translate()),
      ),
      body: BodyDefaultComponent(
        children: [
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            value: ThemeMode.system,
            title: Text('system_mode'.translate()),
            groupValue: controller.themeSelected.value,
            onChanged: (ThemeMode? themeMode) {
              if (themeMode == null) {
                return;
              }
              controller.onChangeTheme(themeMode);
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            value: ThemeMode.dark,
            title: Text('dark_mode'.translate()),
            groupValue: controller.themeSelected.value,
            onChanged: (ThemeMode? themeMode) {
              if (themeMode == null) {
                return;
              }
              controller.onChangeTheme(themeMode);
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            value: ThemeMode.light,
            title: Text('light_mode'.translate()),
            groupValue: controller.themeSelected.value,
            onChanged: (ThemeMode? themeMode) {
              if (themeMode == null) {
                return;
              }
              controller.onChangeTheme(themeMode);
            },
          ),
        ],
      ),
    );
  }
}
