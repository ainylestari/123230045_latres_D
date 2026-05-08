import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login_page.dart';
import 'pages/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cartBox');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  final String? username;

  const MyApp({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shop',
      home: username != null
          ? MainNavigation(username: username!)
            : const LoginPage(),
    );
  }
}