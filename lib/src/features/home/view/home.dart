import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:meus_gastos/src/features/home/controller/home.controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> tabPages = const <Widget>[];

  HomeController homeCtrl = HomeController();

  @override
  void initState() {
    tabPages = <Widget>[_buildMyExpenses(), _buildMyCategories()];

    homeCtrl.loadCategories();
    super.initState();
  }

  _buildMyExpenses() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Meus gastos', style: titleStyle2),
          ),
        ),
        BlocBuilder<HomeController, HomeStates>(
          bloc: homeCtrl,
          builder: (BuildContext context, HomeStates state) {
            if (state is HomeLoading) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                ),
              );
            } else if (state is HomeSuccess) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  final Category category = state.categories[index];

                  return Center(
                    child: Dismissible(
                      key: const Key('categoriesList'),
                      onDismissed: (DismissDirection dir) => homeCtrl.action(dir, context),
                      background: Container(
                        color: primary,
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            'Editar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: primary,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Text(
                            'Deletar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          category.description,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.categories.length,
              );
            } else if (state is HomeError) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.not_interested),
                    Text(state.error),
                  ],
                ),
              );
            } else {
              return SliverToBoxAdapter(child: Container());
            }
          },
        ),
      ],
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () => homeCtrl.toLogin(context),
            child: Text('Logout', style: TextStyle(color: primary, fontSize: 20)),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: primary,
            onPressed: () => homeCtrl.openAddEdit(_selectedIndex, context),
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
