// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart'; // Add provider package import
import 'package:task_manager_application/pages/Homepage.dart';// Ensure this path is correct
import 'package:task_manager_application/theme/theme_provider.dart';

import 'pages/tasktracker.dart'; // Add the theme provider import

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Mybox');

  runApp(
    ChangeNotifierProvider( // Wrapping the app with ChangeNotifierProvider
      create: (context) => ThemeProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>( // Using Consumer to listen to theme changes
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData, // Applying the current theme
          home:  Homepage(), // Home page is the Homepage widget
          routes: {
            '/tasktracker': (context) => const tasktracker(), // Correct route to TaskTracker page
          },
        );
      },
    );
  }
}
