import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/main_dependency.dart';
import 'package:password_manager/main_widget.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DependencyProvider.injectDependency();
  var providers = MainDependency.providers();
  runApp(
    MultiProvider(
      providers: providers,
      child: const MainWidget(),
    ),
  );
}
