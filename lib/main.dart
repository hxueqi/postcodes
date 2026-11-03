import 'package:flutter/material.dart';
import 'package:postcodes/screens/search_screen.dart';
import 'package:postcodes/styles/app_styles.dart';

void main() {
  runApp(const PostcodesApp());
}

class PostcodesApp extends StatelessWidget {
  const PostcodesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codis postals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppStyles.primary,
          primary: AppStyles.primary,
          secondary: AppStyles.accent,
        ),
        scaffoldBackgroundColor: AppStyles.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primary,
          foregroundColor: AppStyles.surface,
        ),
      ),
      home: const SearchScreen(),
    );
  }
}
