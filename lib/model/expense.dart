import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Categories { food, travel, lesuire, work }

const CategoryIcons = {
  Categories.food: Icons.food_bank,
  Categories.travel: Icons.airplanemode_on,
  Categories.lesuire: Icons.movie,
  Categories.work: Icons.work
};

const uuid = Uuid();

DateFormat formatter = DateFormat.yMd();

class Expense {
  Expense(
      {required this.title,
      required this.date,
      required this.amount,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Categories category;

  get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final List<Expense> expenses;
  final Categories category;

  double get totalExpenses {
    double sum = 0;

    for (final exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }
}
