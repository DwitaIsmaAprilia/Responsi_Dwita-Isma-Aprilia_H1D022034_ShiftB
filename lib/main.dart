import 'package:flutter/material.dart';
import 'package:keuangan/helpers/user_info.dart';
import 'package:keuangan/ui/login_page.dart';
import 'package:keuangan/ui/saldo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    // Check if the user is logged in by retrieving the token
    var token = await UserInfo().getToken();

    // Update the page based on the token availability
    if (token != null) {
      setState(() {
        page = const SaldoPage(); // Navigate to the SaldoPage if logged in
      });
    } else {
      setState(() {
        page = const LoginPage(); // Navigate to the LoginPage if not logged in
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Keuangan',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: page), // Center the loading indicator or page
      ),
    );
  }
}



