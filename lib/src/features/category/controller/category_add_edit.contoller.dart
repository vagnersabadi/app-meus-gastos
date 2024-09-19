import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/services/firebase_cloud/firebase_cloud.service.dart';
import 'package:uuid/uuid.dart';

class CategoryAddEditController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  Category? category;

  save(BuildContext context) {
    if (category != null) {
      Category categoryEdited = Category(
        id: category!.id,
        name: name.text,
        description: description.text,
      );
      FirebaseCloudService.editCategory(categoryEdited);
    } else {
      Category category = Category(
        id: const Uuid().v1(),
        name: name.text,
        description: description.text,
      );
      FirebaseCloudService.saveCategory(category);
    }

    Navigator.pop(context);
  }

  cancel() {}

  paramsEdit(Category? c) {
    if (category != null) {
      category = c;
      name.text = c!.name;
      description.text = c.description;
    }
  }
}
