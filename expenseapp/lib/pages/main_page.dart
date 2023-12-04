import 'package:expenseapp/pages/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/new_expense.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //final List<Expense> expenses = [];
  final List<Expense> expenses = [
    Expense(
        name: "Yiyecek",
        price: 200.524,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        name: "Flutter Udemy Course",
        price: 200,
        date: DateTime.now(),
        category: Category.education),
  ];
  void _addExpense(Expense newExpense) {
    setState(() {
      expenses.add(newExpense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
      _showDeleteSnackbar(context, expense);
    });
  }

  void _undoRemoveExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expense restored'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ExpenseApp"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => Builder(
                  builder: (context) => NewExpense(addExpense: _addExpense),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: expenses.length > 0
          ? ExpenseList(expenses: expenses, onRemove: removeExpense)
          : Text("Henüz hiç bir veri girmediniz.."),
    );
  }

  void _showDeleteSnackbar(BuildContext context, Expense expense) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            _undoRemoveExpense(expense);
            scaffold.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
