import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/models/expense/expenseType.enum.dart';
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
    homeCtrl.loadExpenses();
    super.initState();
  }

  Container _buildCard(
      Color color, IconData icon, String subTitle, String value) {
    return Container(
      height: 150,
      width: 220,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 16),
                child: Icon(
                  icon,
                  size: 34,
                ),
              )
            ],
          ),
          Center(
            child: Column(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subTitle)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildListExpenses() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lançamentos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        BlocBuilder<HomeController, HomeStates>(
          bloc: homeCtrl,
          builder: (BuildContext context, HomeStates state) {
            if (state is HomeExpensesLoading) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                ),
              );
            } else if (state is HomeExpensesSuccess) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  final Expense expense = state.expenses[index];
                  final bool isInput = expense.type == TypeExpense.input.name;
                  Color colorText = isInput ? tertiary : secondary;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Dismissible(
                        key: ValueKey<Expense>(expense),
                        onDismissed: (DismissDirection dir) =>
                            homeCtrl.actionExpense(dir, context, expense),
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
                          leading: isInput
                              ? Icon(Icons.arrow_circle_down, color: tertiary)
                              : Icon(Icons.arrow_circle_up, color: secondary),
                          title: Text(
                            expense.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            expense.category.name,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'R\$ ${expense.value}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorText,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(expense.date),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.expenses.length,
              );
            } else if (state is HomeExpensesError) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.not_interested),
                    Text(state.error),
                  ],
                ),
              );
            } else if (state is HomeExpensesEmpty) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.msg,
                      style: TextStyle(color: primary, fontSize: 26),
                    ),
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

  _buildMyExpenses() {
    return BlocBuilder<HomeController, HomeStates>(
      bloc: homeCtrl,
      builder: (context, state) {
        String inputValue = '0';
        String outputValue = '0';

        if (state is HomeExpensesCards) {
          inputValue = state.inputValue;
          outputValue = state.outputValue;
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Meus gastos', style: titleStyle2),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(
                      tertiary,
                      Icons.arrow_circle_down,
                      'Entradas',
                      'R\$ $inputValue',
                    ),
                    _buildCard(
                      secondary,
                      Icons.arrow_circle_up,
                      'Saídas',
                      'R\$ $outputValue',
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: _buildListExpenses(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildMyCategories() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Minhas Categorias', style: titleStyle2),
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
                      key: ValueKey<Category>(category),
                      onDismissed: (DismissDirection dir) =>
                          homeCtrl.action(dir, context, category),
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
            } else if (state is HomeEmpty) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.msg,
                      style: TextStyle(color: primary, fontSize: 26),
                    ),
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

  void _onItemTapped(int index) {
    if (index == 0) {
      homeCtrl.loadExpenses();
    } else {
      homeCtrl.loadCategories();
    }

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
            child: Text(
              'Logout',
              style: TextStyle(color: primary, fontSize: 20),
            ),
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
