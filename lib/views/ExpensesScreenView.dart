// ignore_for_file: non_constant_identifier_names

import 'package:expense_tracker/views/AddExpensesView.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list_widget.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreenView extends StatefulWidget {
  const ExpensesScreenView({super.key});

  @override
  State<ExpensesScreenView> createState() => _ExpensesScreenViewState();
}

class _ExpensesScreenViewState extends State<ExpensesScreenView> {
  final List<Expense> _Registered_expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _Registered_expenses.add(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expense Added Successfully")));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _Registered_expenses.indexOf(expense);
    setState(() {
      _Registered_expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense Removed Successfully"),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _Registered_expenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    const maincontent = Center(
      child: Text("No Expenses Found...Enter Expenses!!!"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormScreenView(
                    OnaddExpense: _addExpense,
                  );
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Chart(expenses: _Registered_expenses),
          const SizedBox(
            height: 30,
          ),
          _Registered_expenses.isNotEmpty
              ? expensesWidget(
                  expenses: _Registered_expenses,
                  onRemoveExpense: _removeExpense,
                )
              : maincontent
        ],
      )),
    );
  }
}
