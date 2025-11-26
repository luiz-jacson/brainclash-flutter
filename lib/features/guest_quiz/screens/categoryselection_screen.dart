import 'package:flutter/material.dart';
import 'package:flutter_brainclash/core/constants/app_colors.dart';
import 'package:flutter_brainclash/core/constants/app_icons.dart';
import 'package:flutter_brainclash/core/widgets/add_account_modal.dart';
import 'package:flutter_brainclash/core/widgets/category_card.dart';
import 'package:flutter_brainclash/models/categoria.dart';
import 'package:flutter_brainclash/services/categoria_service.dart';

final List<CategoryCard> categories = [];

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  Future<List<CategoryCard>> getCategorias() async {
    CategoriaService categoriaService = CategoriaService();
    List<Categoria> categorias = await categoriaService.getAll();
    categorias = categorias.sublist(0, 5);
    List<CategoryCard> listaCards = [];
    for (var categoria in categorias) {
      CategoryCard card = CategoryCard(
        category: categoria,
        icon: AppIcons.parseIcon(categoria.iconCodePoint),
        color: AppColors.parseColor(categoria.colorHex),
      );
      listaCards.add(card);
    }
    return listaCards;
  }

  Future<void> refreshGetAll() async {
    setState(() {
      getCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8E9CE7), Color(0xFF5D74EA)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Olá!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('👋', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                const Text(
                  'Escolha sua categoria preferida para iniciar',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 30),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshGetAll,
                    child: FutureBuilder<List<CategoryCard>>(
                      future: getCategorias(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Erro ao carregar categorias"),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text("Nenhuma categoria encontrada"),
                          );
                        }

                        final categorias = snapshot.data!;

                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.1,
                          children: categorias,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddAccountModal();
            },
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
