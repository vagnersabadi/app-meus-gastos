import 'package:meus_gastos/src/core/models/category/category.model.dart';

class HomeServices {


    Future<List<Category>> fetchCategories() async {

        await Future.delayed(const Duration(seconds: 1));

        return [
            Category(name: 'Nome1', description: 'description1'),
            Category(name: 'Nome2', description: 'description2'),
            Category(name: 'Nome2', description: 'description2'),
            Category(name: 'Nome2', description: 'description2'),
            Category(name: 'Nome2', description: 'description2'),
            Category(name: 'Nome2', description: 'description2'),
            Category(name: 'Nome2', description: 'description2'),
            Category(name: 'Nome2', description: 'description2'),
            
        ];
    }

}