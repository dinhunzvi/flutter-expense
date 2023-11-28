import 'package:flutter/material.dart';
import 'package:flutter_expense/components/expense_tile.dart';
import 'package:flutter_expense/data/expense_data.dart';
import 'package:flutter_expense/models/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child ) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) =>
                  ExpenseTile(
                      name: value.getAllExpenseList()[index].name,
                      amount: value.getAllExpenseList()[index].amount,
                      dateTime: value.getAllExpenseList()[index].dateTime)),
        ));
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Expense details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // expense name
              TextField(
                controller: newExpenseNameController,
              ),
              // expense amount
              TextField(
                controller: newExpenseAmountController,
              )
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Save button
                MaterialButton(
                  onPressed: save,
                  child: const Text('Save'),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('Cancel'),
                )
              ],
            )
          ],
        ));
  }

  // save expense
  void save() {
    // create expense item
    ExpenseItem expenseItem = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now());
    // add the new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(expenseItem);
    clearControllers();
    Navigator.pop(context);
  }

  // cancel adding expense
  void cancel() {
    Navigator.pop(context);
  }

  void clearControllers() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }
}
