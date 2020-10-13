import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  /*
  final List<Map<String, Object>> _pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      // 這邊會error，因此區塊正在初始化所以不能用widget.favoriteMeals
      //要在initState裡面使用才可以
      'page': FavoritesScreen(widget.favoriteMeals),
      'title': 'Your Favorites',
    },
  ];
*/

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        // 因為在initState中，widget is available 才可如下這樣寫assign to _pages
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex, //讓BottomNavigationBar知道哪個tab被選到
        type: BottomNavigationBarType.shifting, //default is fixed
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories', //title deprecated , so use label instead
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites', //title deprecated , so use label instead
          ),
        ],
      ),
    );
  }
}
