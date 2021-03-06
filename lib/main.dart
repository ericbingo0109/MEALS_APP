import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import './models/meal.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      // 這邊是從DUMMY_MEALS抓出所有依據filter設定的結果
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          // 如果filter設定 gluten-free 無麩質飲食 true(也就是要抓出 gluten-free 的meal)
          // 這邊就排除掉 非gluten-free的meal
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // 加入 or 移除 我的最愛
  void _toggleFavorite(String mealId) {
    // 若無favorite則回傳-1，若有找到的話就回傳該meal在favorte中的index
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                //body1 以及body2已經於2014 version of material design棄用
                // title 也是棄用改用headline6
                // 可看這網頁 https://stackoverflow.com/questions/60864189/body2-is-deprecated-and-shouldnt-be-used-this-is-the-term-used-in-the-2014-ver
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        // '/': (context) => CategoriesScreen(), //等同上面的 home: CategoriesScreen(),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters), //也傳入_filters更新filter設定
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // 這是當找不到對應的頁面時的處理function，可以放404之類的頁面
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
/**
 * 測驗 15
 * Q:What's the idea of onGenerateRoute?
 * A:It takes a function which executes for any named navigation action (= pushNamed()) for which no registered route was found in the routes table. 
 * You should return a navigation action (e.g. MaterialPageRoute) in onGenerateRoute.
 * onGenerateRoute is your fallback/ option to have more control about the creation + configuration 
 * of routing actions (= MaterialPageRoute that then loads a specific screen widget).
 * 
 * Q:What's the difference between onGenerateRoute and onUnknownRoute?
 * A: onGenerateRoute executes for any unregistered named route, 
 * onUnknownRoute executes if onGenerateRoute isn't defined or doesn't return a valid navigation action.
 * 
 */
/**
 * 測驗14
 * Q: What's a "Screen" in a Flutter App?
 * A: A widget which controls the entire screen (or at least makes up the main content of the screen).
 * A screen is a normal widget but it's loaded such that it fills the entire (or the majority) of the device screen. 
 * Typically, it also controls the app bar etc.
 * 
 * Q: What's true about "Screens" and "normal Widgets"?
 * A: Both are normal widgets in the end, the only difference is how the widgets are used & which role they play.
 * There is no technical difference between the different kinds of widgets.
 * 
 * 這題重要 Q: What's the difference between push() and pushNamed()?
 * A: push() navigates to a new screen by creating it "on the fly", pushNamed() can only load screens which were registered in advance.
 * push() creates the MaterialPageRoute object "on the fly" (i.e. in the place where you call push()) 
 * whereas pushNamed() only works with pre-registered routes (in the routes table of your MaterialApp widget).
 * 
 * 這題重要 Q: What exactly is a "named route"?
 * A: A route which is registered in the routes table - it receives a "name" (key) with which it can be loaded there.
 * You register key (name) value (route builder function) pairs in the routes table of your MaterialApp/ CupertinoApp widget. 
 * These are the "named routes" you can use with pushNamed().
 * 
 * Q: What's the "Stack of Pages" (or "Stack of Screens")?
 * A: It's an important concept in mobile navigation. 
 * New pages are typically pushed on top of the "Stack of Pages/ Screens". 
 * The top-most (i.e. latest) page/ screen is the visible screen. 
 * Popping the latest screen therefore moves back to an older screen.
 * Screen widgets are managed in a stack and you always see the top-most screen. 
 * Old screens are also kept around (i.e. not deleted) but currently not visible. 
 * If you move back, you see the old page again since the newer page got popped off the stack.
 */
