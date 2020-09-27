import 'package:flutter/material.dart';
import './dummy_data.dart';
import './category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      children: DUMMY_CATEGORIES
          .map((catgoryData) => CategoryItem(
                catgoryData.title,
                catgoryData.color,
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, //200pixels
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20, // 定義grid彼此之間（在column & row 方向）的寬度
        mainAxisSpacing: 20, // 定義grid彼此之間（在column & row 方向）的寬度
      ),
    );
  }
}
