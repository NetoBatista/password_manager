import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/app_widget.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyProvider.injectDependency();
  runApp(
    AppWidget(
      themeService: DependencyProvider.get<IThemeService>(),
    ),
  );
}
