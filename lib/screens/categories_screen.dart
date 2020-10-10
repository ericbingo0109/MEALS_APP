import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeal'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map(
              (catgoryData) => CategoryItem(
                catgoryData.id,
                catgoryData.title,
                catgoryData.color,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, //200pixels
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, // 定義grid彼此之間（在column & row 方向）的寬度
          mainAxisSpacing: 20, // 定義grid彼此之間（在column & row 方向）的寬度
        ),
      ),
    );
  }
}
