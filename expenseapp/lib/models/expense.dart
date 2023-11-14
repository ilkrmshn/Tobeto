import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, education, travel, work }

const categoryIcons = {
  Category.food: Icons.food_bank,
  Category.education: Icons.cast_for_education,
  Category.travel: Icons.card_travel,
  Category.work: Icons.business
};
const categoryColors = {
  Category.food: Color.fromARGB(255, 230, 70, 70),
  Category.education: Color.fromARGB(255, 104, 157, 244),
  Category.travel: Color.fromARGB(255, 172, 54, 205),
  Category.work: Color.fromARGB(255, 35, 152, 105)
};

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

  String get formattedDate {
    var formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}
