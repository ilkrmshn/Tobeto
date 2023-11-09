import 'package:expenseapp/pages/expense_list.dart';
import 'package:flutter/material.dart';

// Single Responsibility
void main() {
  runApp(
    MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("ExpenseApp"),
              actions: [
                IconButton(
                  onPressed: () {
                    showSnackBar(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: ExpenseList(),
          );
        },
      ),
    ),
  );
}

void showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Ekle butonuna tıklandı."),
  ));
}
