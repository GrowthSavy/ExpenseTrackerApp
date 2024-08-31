import 'package:flutter/material.dart';
import 'package:myapp/models/expense.dart';
import 'package:myapp/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: Theme.of(context).cardTheme.margin,
          ),
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseItem(
              expense: expenses[index],
            )));
  }
}
