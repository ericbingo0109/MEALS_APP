import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      // 取得 main.dart 設定的rounte arguments
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    print('hello....mealId= ' + mealId);
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            // removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
/**
 * 測驗17
 * Q:What's the core difference between pushReplacement() and push()?
 * A:pushReplacement() replaces the current screen in the stack
 * 
 * Q:Consider this snippet:
 *    push(...).then(fn)
 *   where fn is a function.
 *  When does that function execute?
 * A: As soon as the new screen is popped.
 * then() triggers fn as soon as you leave (pop) the new screen that was loaded via push()
 * 原本push上去的新screen在被popped之後（例如：刪除）才執行then裡面的fn
 * 
 * Q:How can you retrieve the data passed back via Navigator.of(context).pop('some data')?
 * A:You can retrieve it as an argument to the function you use in then() after push()/pushNamed() etc. 
 * The data you pass to pop() is automatically passed into the function (as an argument) 
 * that executes inside of then() once pop() is triggered.
 * 
 */
