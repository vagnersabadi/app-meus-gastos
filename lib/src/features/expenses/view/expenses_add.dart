import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/models/expense/expenseType.enum.dart';
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

  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Entrada"),
    1: Text("Saída")
  };

  List<Category> categories = [];

  String title = 'Adicionar';
  bool submitName = false;
  bool submitDesc = false;

  late SingleValueDropDownController _cnt;

  @override
  initState() {
    _cnt = SingleValueDropDownController();

    super.initState();

    expenseCtrl.fetchCategories().then((List<Category> c) {
      setState(() {
        categories = c;
      });
    });

    if (widget.expense != null) {
      expenseCtrl.expense = widget.expense;

      Expense expense = widget.expense!;

      expenseCtrl.title.text = expense.title;
      expenseCtrl.value.text = expense.value.toString();
      expenseCtrl.date.text = expense.date;
      expenseCtrl.segmentedType =
          expense.type == TypeExpense.input.name ? 0 : 1;
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
    _cnt.dispose();
    expenseCtrl.title.dispose();
    expenseCtrl.value.dispose();
    expenseCtrl.date.dispose();
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
              groupValue: expenseCtrl.segmentedType,
              children: myTabs,
              onValueChanged: (i) {
                setState(() {
                  expenseCtrl.segmentedType = i!;
                });
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: expenseCtrl.value,
              inputFormatters: [expenseCtrl.formatter],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor',
                hintText: 'R\$ 0,00',
                prefixIcon: expenseCtrl.segmentedType == 0
                    ? Container(
                        height: 50,
                        color: tertiary,
                        child: const Icon(Icons.arrow_circle_down),
                      )
                    : Container(
                        height: 50,
                        color: secondary,
                        child: const Icon(Icons.arrow_circle_up),
                      ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) => expenseCtrl.validatorValue(value),
            ),
            const SizedBox(height: 40),
            DropDownTextField(
              controller: _cnt,
              clearOption: false,
              enableSearch: false,
              textFieldDecoration: const InputDecoration(
                labelText: 'Categoria',
                hintText: 'Selecionar categoria',
                border: OutlineInputBorder(),
              ),
              validator: (value) => expenseCtrl.validatorTitle(value),
              dropDownItemCount: 6,
              dropDownList: categories.map((Category c) {
                return DropDownValueModel(
                  name: c.name,
                  value: c,
                );
              }).toList(),
              onChanged: (value) => expenseCtrl.category = value.value,
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
              validator: (value) => expenseCtrl.validatorDate(value),
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
