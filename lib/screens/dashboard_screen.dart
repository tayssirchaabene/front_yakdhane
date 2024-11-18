import 'package:flutter/material.dart';
import 'package:admin_dashbord/screens/categories_page.dart';
import 'package:admin_dashbord/screens/orders_page.dart';
import 'package:admin_dashbord/screens/products_page.dart';
import 'package:admin_dashbord/screens/users_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Barre latérale
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Logo
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Menu de navigation
                  SidebarItem(
                    icon: Icons.shopping_cart,
                    label: "Gestion des Produits",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductsPage()),
                      );
                    },
                  ),
                  SidebarItem(
                    icon: Icons.group,
                    label: "Gestion des Utilisateurs",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UsersPage()),
                      );
                    },
                  ),
                  SidebarItem(
                    icon: Icons.category,
                    label: "Gestion des Catégories",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCategoryPage()),
                      );
                    },
                  ),
                  SidebarItem(
                    icon: Icons.list_alt,
                    label: "Gestion des Commandes",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Contenu principal
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barre supérieure
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Recherches",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('images/'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Cartes statistiques
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatCard(
                        title: "Produit",
                        count: 720,
                        icon: Icons.group,
                        onTap: () {
                          // Action de navigation vers la page des produits
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsPage()),
                          );
                        },
                      ),
                      StatCard(
                        title: "Utilisateur",
                        count: 820,
                        icon: Icons.post_add,
                        onTap: () {
                          // Action de navigation vers la page des utilisateurs
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersPage()),
                          );
                        },
                      ),
                      StatCard(
                        title: "Commandes",
                        count: 920,
                        icon: Icons.pages,
                        onTap: () {
                          // Action de navigation vers la page des commandes
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrdersPage()),
                          );
                        },
                      ),
                      StatCard(
                        title: "Catégories",
                        count: 920,
                        icon: Icons.comment,
                        onTap: () {
                          // Action de navigation vers la page des catégories
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCategoryPage()),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Graphique principal
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Users",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Graphique des utilisateurs\n(Ajoutez une bibliothèque de chart)",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Discussions",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: ListView(
                                      children: List.generate(5, (index) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundImage:
                                                AssetImage('images/'),
                                          ),
                                          title: Text("Nom ${index + 1}"),
                                          subtitle: Text("Jan 25, 2021"),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Composant de la barre latérale
class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap; // Correctement typé

  SidebarItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      onTap: onTap, // Correctement passé
    );
  }
}

// Composant des cartes statistiques
class StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final VoidCallback onTap; // Correctement typé

  StatCard(
      {required this.title,
      required this.count,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Utilisation de InkWell pour la gestion du tap
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Container(
          width: 150,
          height: 100,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue, size: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                "$count",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
