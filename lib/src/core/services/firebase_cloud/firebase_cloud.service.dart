import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/services/storage/storage.service.dart';


class FirebaseCloudService {
  static FirebaseFirestore? _preferences;

  static Future<void> _getPreferences() async {
    _preferences = FirebaseFirestore.instance;
  }


  static Future<void> saveCategory(Category value) async {
    await _getPreferences();
    var user = await StorageService.getString(SharedPreferencesKeys.userLogin);



    // await _preferences!.collection().doc(value.id).set(value.toMap());
  }
}
