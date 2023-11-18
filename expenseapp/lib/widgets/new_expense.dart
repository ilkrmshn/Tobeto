import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense) addExpense;

  const NewExpense({Key? key, required this.addExpense}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Controller
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  void _openDatePicker() async {
    DateTime now = DateTime.now();
    DateTime oneYearAgo = DateTime(now.year - 1, now.month, now.day);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? now : _selectedDate!,
      firstDate: oneYearAgo,
      lastDate: now,
    );

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _addNewExpense() {
    final amount = double.tryParse(_amountController.text);

    if (amount == null ||
        amount < 0 ||
        _nameController.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Doğrulama Hatası"),
            content: const Text("Lütfen tüm boş alanları doldurunuz."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
    } else {
      Expense newExpense = Expense(
        name: _nameController.text,
        price: amount,
        date: _selectedDate!,
        category: _selectedCategory,
      );

      widget.addExpense(newExpense);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Gider Eklendi"),
            content: const Text("Gider başarıyla eklendi."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Tamam"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: const InputDecoration(labelText: "Expense Name"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    prefixText: "₺",
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => _openDatePicker(),
                      icon: const Icon(Icons.calendar_month),
                    ),
                    // Ternary Operator
                    Text(_selectedDate == null
                        ? "Tarih Seçiniz"
                        : DateFormat.yMd().format(_selectedDate!)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) _selectedCategory = value;
                  });
                },
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Vazgeç"),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  _addNewExpense();
                },
                child: const Text("Ekle"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
