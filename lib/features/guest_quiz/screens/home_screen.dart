import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F0F0),
        title: Text("Brainclash"),
        actions: [
          IconButton(onPressed: () => Navigator.pushReplacementNamed(context, "login"), icon: Icon(Icons.logout))
        ],
      ),

    );
  }
}