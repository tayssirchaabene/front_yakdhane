import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prixController = TextEditingController();
  final _quantiteController = TextEditingController();
  final _ipController = TextEditingController();
  String? _selectedCategory;
  File? _image;

  // Liste des catégories récupérées depuis l'API
  List<String> _categories = [];
  int? _categoryId;

  // Fonction pour obtenir les catégories depuis l'API
  Future<void> _fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8090/produits/categories'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _categories =
              data.map((category) => category['name'] as String).toList();
        });
      } else {
        throw Exception('Erreur lors du chargement des catégories');
      }
    } catch (e) {
      print('Erreur : $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible de charger les catégories')));
    }
  }

  // Fonction pour soumettre le formulaire
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Veuillez sélectionner une image')));
        return;
      }

      try {
        String nom = _nomController.text;
        String description = _descriptionController.text;
        double prix = double.parse(_prixController.text);
        int quantite = int.parse(_quantiteController.text);
        String ip = _ipController.text;

        Uint8List imageBytes = await _image!.readAsBytes();

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:8090/produits/ajouter'),
        );
        request.fields['nom'] = nom;
        request.fields['description'] = description;
        request.fields['prix'] = prix.toString();
        request.fields['quantite'] = quantite.toString();
        request.fields['adresse_ip'] = ip;
        request.fields['categorie_id'] = _categoryId.toString();
        request.files.add(await http.MultipartFile.fromBytes(
          'image_File',
          imageBytes,
          filename: _image!.path.split('/').last,
        ));

        final response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Produit ajouté avec succès')));
          _formKey.currentState?.reset();
          setState(() {
            _image = null;
            _selectedCategory = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur lors de l\'ajout du produit')));
        }
      } catch (e) {
        print('Erreur : $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Une erreur est survenue')));
      }
    }
  }

  // Fonction pour sélectionner une image
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Produits"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom du produit'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Entrez un nom' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Entrez une description'
                    : null,
              ),
              TextFormField(
                controller: _prixController,
                decoration: InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Entrez un prix' : null,
              ),
              TextFormField(
                controller: _quantiteController,
                decoration: InputDecoration(labelText: 'Quantité'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Entrez une quantité'
                    : null,
              ),
              TextFormField(
                controller: _ipController,
                decoration: InputDecoration(labelText: 'Adresse IP'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Entrez une adresse IP'
                    : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                    _categoryId = _categories.indexOf(newValue!) + 1;
                  });
                },
                decoration: InputDecoration(labelText: 'Catégorie'),
                items: _categories
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                validator: (value) =>
                    value == null ? 'Sélectionnez une catégorie' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Sélectionner une image"),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.file(
                    _image!,
                    width: 150,
                    height: 150,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Ajouter Produit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
