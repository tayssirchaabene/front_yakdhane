import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final String apiUrl = "http://localhost:8090/produits/categorie/ajouter";
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  Future<void> addCategory(String categoryName) async {
    setState(() {
      isLoading = true; // Afficher le loader
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nom": categoryName}),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Catégorie ajoutée avec succès !")),
        );
        _controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'ajout de la catégorie.")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur réseau : $error")),
      );
    } finally {
      setState(() {
        isLoading = false; // Arrêter le loader
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une Catégorie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nom de la catégorie',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      final categoryName = _controller.text.trim();
                      if (categoryName.isNotEmpty) {
                        addCategory(categoryName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Le nom ne peut pas être vide.")),
                        );
                      }
                    },
                    child: Text("Ajouter"),
                  ),
          ],
        ),
      ),
    );
  }
}
