import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 75,
          leading: Center(
            child: TextButton(
              onPressed: null,
              child: Text('Logout', style: TextStyle(color: primary)),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: primary,
              onPressed: () {
                // handle the press
              },
            ),
          ],
        ),
        body: Container());
  }
}
