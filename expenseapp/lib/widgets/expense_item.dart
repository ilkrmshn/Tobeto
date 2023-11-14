import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: categoryColors[expense.category],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              expense.name,
              style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "${expense.price.toStringAsFixed(2)} ₺",
                  //style: TextStyle(color: categoryColors[expense.category]),
                ),
                const Spacer(),
                const SizedBox(width: 8),
                Icon(
                  categoryIcons[expense.category],
                  //color: categoryColors[expense.category],
                ),
                Text(
                  expense.formattedDate,
                  //style: TextStyle(color: categoryColors[expense.category]),
                ),
                const SizedBox(width: 8),
              ],
            )
          ],
        ),
      ),
    );
  }
}
