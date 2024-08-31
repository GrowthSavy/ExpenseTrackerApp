import 'package:flutter/material.dart';
import 'package:myapp/models/expense.dart';
import 'package:myapp/widgets/expenses_list/expenses_list.dart';
import 'package:myapp/widgets/new_expenses.dart';
import 'package:myapp/widgets/chart/chart.dart';


class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Dart Course",
        amount: 10.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "One Piece Movie",
        amount: 5.59,
        date: DateTime.now(),
        category: Category.entertainment),
    Expense(
        title: "Chole Bhature",
        amount: 2.10,
        date: DateTime.now(),
        category: Category.food)
  ];

  void newExpenseAdd(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final removedExpenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense is deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(removedExpenseIndex, expense);
            });
          }),
    ));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              newExpenseAdd: newExpenseAdd,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("No Expense Yet, Pls Add Expense"));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 255, 216),
          title: const Text(
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), 'Expense Tracker App'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add),color: Colors.black,)
          ],
        ),
        body: Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent)
            ],
        ));
  }
}
