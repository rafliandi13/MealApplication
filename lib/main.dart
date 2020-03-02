import 'package:flutter/material.dart';
import 'package:submission_third/view/breakfast.dart';
import 'package:submission_third/model/ingredients.dart';
import 'package:submission_third/view/desert.dart';

void main() => runApp(new MyApp());

// App root class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'The Ingredients',
        home: new IngredientsPage());
  }
}

// Home page class
class IngredientsPage extends StatefulWidget {
  IngredientsPage({Key key}) : super(key: key);

  @override
  _IngredientsPageState createState() => new _IngredientsPageState();
}

// Home page state class
class _IngredientsPageState extends State<IngredientsPage> {
  List<Ingredients> ingredients = [];
  int _selectedIndex = 0;
  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<Widget> _widgetoption = [
    Breakfast(),
    Desert(),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Foods"),
        ),
        body: Center(
          child: _widgetoption.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped, // new
          currentIndex: _selectedIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.fastfood),
              title: new Text('Seafood'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.local_drink),
              title: new Text('Dessert'),
            ),
          ],
        ),
    );
  }
}