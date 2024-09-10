import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> tabPages = const <Widget>[];

  _buildMyExpenses() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text('Meus Gastos', style: titleStyle2),
            ),
          ],
        ),
      ),
    );
  }

  _buildMyCategories() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text('Minhas Categorias', style: titleStyle2),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    tabPages = <Widget>[_buildMyExpenses(), _buildMyCategories()];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouteEnum.loginPage.name,
                (route) => false,
              )
            },
            child: Text('Logout', style: TextStyle(color: primary, fontSize: 20)),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: primary,
            onPressed: () {
              switch (_selectedIndex) {
                case 0:
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouteEnum.expenseAddPage.name,
                    (route) => false,
                  );
                  break;
                case 2:
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouteEnum.categoryAddPage.name,
                    (route) => false,
                  );
                  break;
                default:
              }
            },
          ),
        ],
      ),
      body: tabPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Lançamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categorias',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
