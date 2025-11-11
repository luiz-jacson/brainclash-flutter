import 'package:flutter/material.dart';
import 'package:flutter_brainclash/features/guest_quiz/screens/categoryselection_screen.dart';
import 'package:flutter_brainclash/features/guest_quiz/screens/home_screen.dart';
import 'package:flutter_brainclash/features/auth/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  // Garante que o Flutter Binding esteja pronto
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // Inicialização do Firebase (assíncrona e obrigatória)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BancoDouroApp());
}

class BancoDouroApp extends StatelessWidget{
  const BancoDouroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "login": (context) => LoginScreen(),
        "home" : (context) => CategorySelectionScreen()
      },
      initialRoute: "login",
    );
  }

}
