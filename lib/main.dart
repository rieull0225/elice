import 'package:elice/router.dart';
import 'package:elice/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context, __) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp.router(
          themeMode: themeProvider.themeMode,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          routerConfig: router,
        );
      },
      create: (context) => ThemeProvider(),
    );
  }
}
