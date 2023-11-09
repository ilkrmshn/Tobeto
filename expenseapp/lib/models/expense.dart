import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, education, travel, work }

class Expense {
  Expense(
      {required this.name,
      required this.price,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Category category;
}
