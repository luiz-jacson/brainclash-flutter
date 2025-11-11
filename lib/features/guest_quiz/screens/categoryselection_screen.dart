import 'package:flutter/material.dart';
import 'package:flutter_brainclash/core/widgets/category_card.dart';
import 'package:flutter_brainclash/models/categoria.dart';
import 'package:flutter_brainclash/services/categoria_service.dart';

final List<CategoryCard> categories = [];

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8E9CE7),
              Color(0xFF5D74EA), 
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Título e saudação
                const Text(
                  'Olá!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '👋',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Escolha sua categoria preferida para iniciar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15, 
                    mainAxisSpacing: 15, 
                    childAspectRatio: 1.1, 
                    children: categories
                        .map((category) => category)
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}