import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './catagories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen({
    Key? key,
    required this.favoriteMeals,
  }) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'page': const CatagoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.key, widget.favoriteMeals),
        'title': 'Your Favorites',
      }
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
        ),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.star),
          ),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.pink,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
