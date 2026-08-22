import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal/get_it.dart';
import 'package:personal/src/ui/pages/auth/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDep();

  await initializeDateFormatting('es_ES', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: AuthPage(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
    );
  }
}
