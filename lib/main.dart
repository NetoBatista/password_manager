import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:password_manager/features/home/home_page.dart';
import 'package:password_manager/features/know_more/know_more_page.dart';
import 'package:password_manager/features/login/login_page.dart';
import 'package:password_manager/features/privacy/privacy_page.dart';
import 'package:password_manager/features/settings/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(letterSpacing: 1),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(letterSpacing: 1),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(letterSpacing: 1),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(letterSpacing: 1),
        ),
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          background: Colors.grey[300],
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [Locale("pt", "BR"), Locale("en", "US")],
      localeResolutionCallback: (locale, supportedLocale) {
        if (supportedLocale.contains(locale)) {
          return locale;
        }
        return const Locale("en", "US");
      },
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/settings': (BuildContext context) => const SettingsPage(),
        '/know_more': (BuildContext context) => const KnowMorePage(),
        '/privacy': (BuildContext context) => const PrivacyPage(),
      },
    );
  }
}
