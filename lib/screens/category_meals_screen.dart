import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> aviliableMeals;
  const CategoryMealsScreen(this.aviliableMeals, {Key? key}) : super(key: key);

  // final String categoryId;
  // final String categoryTitle;
  //const CategoryMealsScreen({
  // Key? key,
  // required this.categoryId,
  // required this.categoryTitle,
  // }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> displayedMeals = [];
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      displayedMeals = widget.aviliableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  //Del the list of the food....
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    //extracting data from named route...

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
