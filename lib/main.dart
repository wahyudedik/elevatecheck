import 'package:elevatecheck/core/di/dependency.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

void main() async {
  await initializeDateFormatting('id', '');
  // await initializeDateFormatting('id', null);
  await initDependency();
  await NotificationHelper.initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
