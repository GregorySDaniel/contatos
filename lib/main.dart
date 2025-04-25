import 'package:contatos/providers/contact.dart';
import 'package:contatos/providers/theme.dart';
import 'package:contatos/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactProvider>(
          create: (_) => ContactProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: context.watch<ThemeProvider>().themeMode,
    );
  }
}
