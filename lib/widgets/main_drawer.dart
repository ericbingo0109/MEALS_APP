import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              return Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTile(
            'Filters',
            Icons.settings,
            () {
              return Navigator.of(context).pushNamed(FiltersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
/**
 * 測驗16
 * Q: What's a difference between using Tabs (no matter which ones) and using push() / pushNamed()?
 * A: Tabs replace the current screen (or a part of it) with a new one, 
 *    push() / pushNamed() add a new screen to the stack.
 * Tabs basically switch between screens, whereas push & pushNamed add and remove screens to / from the stack.
 * 
 * Q:Which widget is important for both Tabs and Drawers?
 * A: The Scaffold widget - you register both there. 
 * You register both drawers and tab bars in the Scaffold 
 * (Tabs can potentially also be registered on the AppBar but that's also registered in the Scaffold widget in turn).
 */
