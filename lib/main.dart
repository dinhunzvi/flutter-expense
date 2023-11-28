import 'package:flutter/material.dart';
import 'package:flutter_expense/data/expense_data.dart';
import 'package:flutter_expense/pages/home_page.dart';
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
        create: (context) => ExpenseData(),
      builder: (context, child) => const MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

