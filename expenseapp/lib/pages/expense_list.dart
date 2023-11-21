import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({Key? key, required this.expenses, required this.onRemove}) : super(key: key);

  final void Function(Expense expense) onRemove;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
            child: Text("Grafik"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(expenses[index]),
                  child: ExpenseItem(expenses[index]),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      // soldan sağa ise
                    }
                    onRemove(expenses[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
