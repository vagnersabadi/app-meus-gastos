import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  int segmentedType = 0;
  int _selectedFruit = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Entrada"),
    1: Text("Saída")
  };
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

  _showDate() async {
    DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      locale: const Locale('pt'),
    );
    if (picked != null) {
      String result = DateFormat('dd/MM/yyyy').format(picked);
      setState(() => expenseCtrl.date.text = result);
    }
  }

  _showDialog() {
    print('Teste');

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
              widget.expense != null
                  ? 'Editar lançamento'
                  : 'Adicionar lançamento',
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
              groupValue: segmentedType,
              children: myTabs,
              onValueChanged: (i) {
                setState(() => segmentedType = i!);
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: expenseCtrl.value,
              inputFormatters: [
                CurrencyTextInputFormatter.currency(
                    locale: 'pt_BR', symbol: 'R\$')
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor',
                hintText: 'R\$ 0,00',
                prefixIcon: Icon(
                  segmentedType == 0
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) => expenseCtrl.validatorDescription(value),
            ),
            const SizedBox(height: 40),
            GestureDetector(
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
            TextFormField(
              onTap: () => _showDate(),
              keyboardType: TextInputType.text,
              controller: expenseCtrl.date,
              decoration: const InputDecoration(
                labelText: 'Data',
                hintText: 'Selecionar data',
                border: OutlineInputBorder(),
              ),
              // validator: (value) => expenseCtrl.validatorTitle(value),
            ),
            const SizedBox(height: 40),
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
