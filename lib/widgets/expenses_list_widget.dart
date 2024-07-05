import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class expensesWidget extends StatelessWidget {
  const expensesWidget(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Dismissible(
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                  child: const Center(child: Icon(Icons.delete)),
                ),
                onDismissed: (direction) {
                  onRemoveExpense(expense);
                },
                direction: DismissDirection.endToStart,
                key: ValueKey(expense),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text('Rs ${expense.amount.toStringAsFixed(2)}'),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(CategoryIcons[expense.category]),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(expense.formatedDate)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
