import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:meus_gastos/src/features/expenses/controller/expense_add_edit.contoller.dart';
import 'package:meus_gastos/src/shared/widgets/button_default.widget.dart';

class ExpenseAddEditPage extends StatefulWidget {
  final Expense? expense;

  const ExpenseAddEditPage({
    super.key,
    this.expense,
  });

  @override
  State<ExpenseAddEditPage> createState() => _ExpenseAddEditPage();
}

class _ExpenseAddEditPage extends State<ExpenseAddEditPage> {
  ExpenseAddEditController expenseCtrl = ExpenseAddEditController();

  int segmentedControlGroupValue = 0;
  int _selectedFruit = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{0: Text("Entrada"), 1: Text("Saída")};
  final List<String> _fruitNames = <String>[
    'Apple',
    'Mango',
  ];
  String title = 'Adicionar';
  bool submitName = false;
  bool submitDesc = false;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      expenseCtrl.expense = widget.expense;
      //   expenseCtrl.name.text = widget.expense!.name;
      //   expenseCtrl.description.text = widget.expense!.description;
    }

    // expense.name.addListener(() {
    //   setState(() {
    //     submitName = expenseCtrl.name.text.isNotEmpty;
    //   });
    // });

    // expense.description.addListener(() {
    //   setState(() {
    //     submitDesc = expenseCtrl.description.text.isNotEmpty;
    //   });
    // });
  }

  @override
  void dispose() {
    // expenseCtrl.name.dispose();
    // expenseCtrl.description.dispose();
    super.dispose();
  }

  _showDialog() {
    CupertinoPicker(
      itemExtent: 32,
      scrollController: FixedExtentScrollController(
        initialItem: _selectedFruit,
      ),
      onSelectedItemChanged: (int selectedItem) {
        setState(() {
          _selectedFruit = selectedItem;
        });
      },
      children: List<Widget>.generate(
        _fruitNames.length,
        (int index) {
          return Center(child: Text(_fruitNames[index]));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: expenseCtrl.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.expense != null ? 'Editar lançamento' : 'Adicionar lançamento',
              style: titleStyle2,
            ),
            const SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: expenseCtrl.title,
              decoration: const InputDecoration(
                labelText: 'Gasto',
                hintText: 'ex: Internet',
                border: OutlineInputBorder(),
              ),
              validator: (value) => expenseCtrl.validatorTitle(value),
            ),
            const SizedBox(height: 40),
            CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlGroupValue,
              children: myTabs,
              onValueChanged: (i) {
                setState(() {
                  segmentedControlGroupValue = i!;
                });
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: expenseCtrl.value,
              decoration: const InputDecoration(
                labelText: 'Valor',
                hintText: 'Informe o valor do lançamento',
                prefixIcon: Icon(
                  Icons.arrow_outward,
                ),
                border: OutlineInputBorder(),
              ),
              validator: (value) => expenseCtrl.validatorDescription(value),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => _showDialog(),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: expenseCtrl.title,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  hintText: 'Selecionar categoria',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => expenseCtrl.validatorTitle(value),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => _showDialog(),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: expenseCtrl.title,
                decoration: const InputDecoration(
                  labelText: 'Data',
                  hintText: 'Selecionar data',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => expenseCtrl.validatorTitle(value),
              ),
            ),
            ButtonDefault(
              text: 'SALVAR',
              //   disabled: !submitDesc || !submitName,
              onPressed: () => expenseCtrl.save(context),
            ),
            const SizedBox(height: 10),
            ButtonDefault(
              text: 'CANCELAR',
              onPressed: () => expenseCtrl.cancel(context),
            )
          ],
        ),
      ),
    );
  }
}
