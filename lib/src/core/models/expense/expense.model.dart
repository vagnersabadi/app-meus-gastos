// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:meus_gastos/src/core/models/category/category.model.dart';

class Expense {
  String title;
  String type;
  String value;
  Category category;
  String date;
  String id;

  Expense({
    required this.id,
    required this.title,
    required this.type,
    required this.value,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'value': value,
      'category': category.toMap(),
      'date': date,
      'id': id,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: (map['title'] ?? '') as String,
      type: (map['type'] ?? '') as String,
      value: (map['value'] ?? '') as String,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      date: (map['date'] ?? '') as String,
      id: (map['id'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);
}
