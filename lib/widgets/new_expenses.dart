import 'package:flutter/material.dart';
import 'package:myapp/models/expense.dart';
import 'package:myapp/widgets/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.newExpenseAdd});

  final void Function(Expense expense) newExpenseAdd;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _expenseTitle = '';
  // void _setTitle(String title){
  //   _expenseTitle = title;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.entertainment;

  void _submitExpense() {
    // validations: 1. title not blank after trim, 2. amount not null  and  (greater than)>0
    // if above validations are not met we se ErrorDialog
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("Invalid Input"),
                content: Text(
                    "Please make sure a valid Name,Amount,Date was entered"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("Cancel"),
                  )
                ],
              ));
      return;
    } else {
      Expense newExpense = Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory);
      Navigator.pop(context);
      widget.newExpenseAdd(newExpense);
    }
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: DateTime.now());
    // Execute after date is selected
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Expense Name')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      prefixText: "\$ ", label: Text('Amount')),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(_selectedDate == null
                      ? "Select Date"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ]),
              )
            ],
          ),
          Row(children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name.toUpperCase(),
                      ));
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                  ;
                }),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("cancel")),
            ElevatedButton(
                onPressed: () {
                  _submitExpense();
                },
                child: const Text("Submit"))
          ])
        ],
      ),
    );
  }
}
