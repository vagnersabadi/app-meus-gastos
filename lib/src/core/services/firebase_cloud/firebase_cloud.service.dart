import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/user/user.model.dart';
import 'package:meus_gastos/src/core/services/storage/storage.service.dart';

class FirebaseCloudService {
  static FirebaseFirestore? _preferences;
  static User? _user;

  static Future<void> _getPreferences() async {
    _preferences = FirebaseFirestore.instance;
  }

  static Future<void> _getUser() async {
    var user = await StorageService.getString(SharedPreferencesKeys.userLogin);
    _user = User.fromJson(user!);
  }

  static Future<void> _init() async {
    Future.wait([
      _getPreferences(),
      _getUser(),
    ]);
  }

  static Future<void> saveCategory(Category value) async {
    await _init();

    await _preferences!.collection(_user!.email).doc(value.id).set(value.toMap());
  }

  static Future<List<Category>> getCategories() async {
    await _init();

    List<Category> categoriesTemp = [];

    QuerySnapshot<Map<String, dynamic>> snap = await _preferences!.collection(_user!.email).get();

    for (var doc in snap.docs) {
      categoriesTemp.add(Category.fromMap(doc.data()));
    }

    return categoriesTemp;
  }

  static Future<void> removeCategory(Category value) async {
    await _init();
    _preferences!.collection(_user!.email).doc(value.id).delete();
  }

  static Future<void> editCategory(Category value) async {
    await _init();
    _preferences!.collection(_user!.email).doc(value.id).set(value.toMap());
  }
}
