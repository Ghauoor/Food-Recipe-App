import 'package:flutter/material.dart';

import './models/meal.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/dummy_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Filter as user set -->
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
// fetching meals
  List<Meal> _aviliableMeals = dUMMYMEALS;
  //Manage the Fav list...
  List<Meal> _favoriteMeals = [];
  // -->
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _aviliableMeals = dUMMYMEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  //Manage add and remove favorite...
  void _toggleFavorite(String mealId) {
    final exisitingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    // toggling add and remove in fav screen
    if (exisitingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exisitingIndex);
      });
    } else {
      _favoriteMeals.add(
        dUMMYMEALS.firstWhere((meal) => meal.id == mealId),
      );
    }
  }
  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Time',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(
          255,
          254,
          229,
          1,
        ),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const CatagoriesScreen(),

      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_aviliableMeals),
        MealDetailScreen.routeName: (ctx) =>  MealDetailScreen(togglefavorite: _toggleFavorite, isFavorite: _isMealFavorite,),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
            ),
      },
      /*
      onGenerateRoute: (setting) {
        print(setting.arguments);
        return MaterialPageRoute(
          builder: ((ctx) => const CatagoriesScreen()),
        );
      },
      */
      onUnknownRoute: (setting) {
        return MaterialPageRoute(
          builder: (cxt) => CategoryMealsScreen(_aviliableMeals),
        );
      },
    );
  }
}
