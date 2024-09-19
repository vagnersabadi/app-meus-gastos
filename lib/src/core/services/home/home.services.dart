import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/services/firebase_cloud/firebase_cloud.service.dart';

class HomeServices {

    Future<List<Category>> fetchCategories() async {
        return FirebaseCloudService.getCategories();
    }

}