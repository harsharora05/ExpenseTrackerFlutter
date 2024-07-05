import 'package:expense_tracker/views/ExpensesScreenView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.brown.shade400);
var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 16, 100, 123));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: kDarkColorScheme,
          appBarTheme: AppBarTheme(
              backgroundColor: kDarkColorScheme.onSecondaryContainer,
              foregroundColor: kDarkColorScheme.inversePrimary),
          cardTheme: CardTheme(color: kDarkColorScheme.onSecondaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.inversePrimary))),
      theme: ThemeData(useMaterial3: true).copyWith(
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme(
              backgroundColor: kColorScheme.primaryFixed,
              foregroundColor: kColorScheme.onPrimaryFixed),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.inversePrimary))),
      themeMode: ThemeMode.system, //by default
      home: const ExpensesScreenView(),
    );
  }
}
