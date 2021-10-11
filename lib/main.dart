import 'package:flutter/material.dart';
import 'features/random_number/presentation/pages/random_number_page.dart';
import 'injection_container.dart' as injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Random Number',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      home: RandomNumberPage(),
    );
  }
}