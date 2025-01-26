import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:password_manager/main_dependency.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({
    super.key,
  });

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final IThemeService _themeService = DependencyProvider.get();
  Map<String, Widget Function(BuildContext)> routes = {};

  @override
  void initState() {
    routes = MainDependency.mapRoutes();
    super.initState();
    _themeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeService.getCurrent(),
      builder: (context, snapshot, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: snapshot,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
          ],
          supportedLocales: const [
            Locale("pt", "BR"),
            Locale("en", "US"),
          ],
          localeResolutionCallback: (locale, supportedLocale) {
            if (supportedLocale.contains(locale)) {
              return locale;
            }
            return const Locale("en", "US");
          },
          routes: routes,
        );
      },
    );
  }
}
