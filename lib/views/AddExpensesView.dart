import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class FormScreenView extends StatefulWidget {
  const FormScreenView({super.key, required this.OnaddExpense});

  final void Function(Expense exp) OnaddExpense;

  @override
  State<FormScreenView> createState() => _FormScreenViewState();
}

class _FormScreenViewState extends State<FormScreenView> {
  final _TitleController = TextEditingController();
  final _AmountController = TextEditingController();

  Categories selected_category = Categories.food;
  DateTime? SelectedDate;

  void _getDate() async {
    final initial_date = DateTime.now();
    final _firstdate =
        DateTime(initial_date.year - 1, initial_date.month, initial_date.day);
    final Picked_date = await showDatePicker(
        context: context, firstDate: _firstdate, lastDate: initial_date);

    setState(() {
      SelectedDate = Picked_date;
    });
  }

  void _saveExpenses() {
    final enterdAmount = double.tryParse(_AmountController.text);

    if (_TitleController.text.trim().isEmpty ||
        enterdAmount == null ||
        enterdAmount <= 0 ||
        SelectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Invalid Input!!!"),
              content: const Text(
                  "Please enter a valid Title, Amount, Date & Category"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            );
          });
      return;
    } else {
      widget.OnaddExpense(Expense(
          title: _TitleController.text,
          date: SelectedDate!,
          amount: enterdAmount,
          category: selected_category));

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _TitleController.dispose();
    _AmountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expenses"),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  TextField(
                    controller: _TitleController,
                    decoration: const InputDecoration(label: Text("Title")),
                    maxLength: 50,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _AmountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixIcon: Icon(Icons.currency_rupee)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SelectedDate == null
                                ? const Text("No Selected Date")
                                : Text(formatter
                                    .format(SelectedDate as DateTime)
                                    .toString()),
                            IconButton(
                                onPressed: _getDate,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
                          value: selected_category,
                          items: Categories.values.map((category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selected_category = value!;
                            });
                          }),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: _saveExpenses,
                              child: const Text("Save")),
                          TextButton(
                              onPressed: (Navigator.of(context).pop),
                              child: const Text("Cancel"))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
