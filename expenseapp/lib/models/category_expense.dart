import 'package:expenseapp/models/expense.dart';

class CategoryExpense {
  const CategoryExpense({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  CategoryExpense.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpensePrice {
    double sum = 0;

    expenses.forEach((element) {
      sum += element.price;
    });

    return sum;
  }
}
