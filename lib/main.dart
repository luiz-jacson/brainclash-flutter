import 'package:flutter/material.dart';
import 'package:flutter_brainclash/screens/home_screen.dart';
import 'package:flutter_brainclash/screens/login_screen.dart';

void main() {
  runApp(const BancoDouroApp());
}

class BancoDouroApp extends StatelessWidget{
  const BancoDouroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (context) => LoginScreen(),
        "home" : (context) => HomeScreen()
      },
      initialRoute: "login",
    );
  }

}
