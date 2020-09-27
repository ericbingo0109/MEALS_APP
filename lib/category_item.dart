import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  // const CategoryItem({Key key, this.title, this.color}) : super(key: key);
  CategoryItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      // color: color, 這行多寫了，因為已經用了decoration所以不要設定color了 難怪會error: Cannot provide both a color and a decoration
      //使用 BoxDecoration 可讓背景色有較為複雜多變的呈現
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // 設定顏色層次變化
          colors: [
            color.withOpacity(0.7), //讓顏色有點透明度
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
