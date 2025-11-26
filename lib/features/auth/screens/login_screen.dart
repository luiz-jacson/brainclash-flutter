import 'package:flutter/material.dart';
import 'package:flutter_brainclash/core/constants/app_colors.dart';
import 'package:flutter_brainclash/models/categoria.dart';
import 'package:flutter_brainclash/services/categoria_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _signInWithGoogle() {
    print('Logando com Google...');
  }

  void _playAsGuest(context){
    Navigator.pushReplacementNamed(context, "home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/images/login-illustration.png', height: 200),

              const SizedBox(height: 32),

              const Text(
                'BrainClash',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Teste seus conhecimentos e desafie seus amigos!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),

              const SizedBox(height: 50),

              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: Image.asset(
                  'assets/images/google_icon.png',
                  height: 24.0,
                ),
                label: const Text(
                  'Fazer login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.googleButtonColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => _playAsGuest(context),
                child: const Text(
                  'Jogar como Convidado',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
