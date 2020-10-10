import 'package:flutter/material.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        '/': (context) => CategoriesScreen(), //等同上面的 home: CategoriesScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
      },
    );
  }
}
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
