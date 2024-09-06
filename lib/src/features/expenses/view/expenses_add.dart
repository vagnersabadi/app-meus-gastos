import 'package:flutter/material.dart';

class ExpenseAddPage extends StatefulWidget {
  const ExpenseAddPage({super.key});

  @override
  State<ExpenseAddPage> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAddPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pagina add Gastos'),
    );
  }
}
