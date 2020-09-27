import 'package:flutter/material.dart';
import './category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  // const CategoryItem({Key key, this.title, this.color}) : super(key: key);
  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    /*
    Navigator.of(ctx).push(
      MaterialPageRoute(
        // tip : control + space可以顯示出可用的選項
        builder: (_) {
          return CategoryMealsScreen(id, title);
        },
      ),
    );
    */
    // 改用pushNamed的方式傳遞data
    Navigator.of(ctx).pushNamed(
      '/category-meals',
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 許多時候我們希望自定義按鈕 或 幫某個widget增加點擊事件
     * 最常見的作法就是用 InkWell 或者 GestureDetector 將widgets 包起來
     * InkWell 有 onTap, onDoubleTap, onLongPress 方法
     * GestureDetector 與 InkWell 類似，但有更多處理手勢(ex: drag)的方法
     * InkWell 有 ripple effect tap (點擊後有波紋效果)； GestureDetector則沒有
     */
    return InkWell(
      // 單擊
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onDoubleTap: () {
        // 雙擊
      },
      onLongPress: () {
        // 長按
      },
      child: Container(
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
      ),
    );
  }
}
