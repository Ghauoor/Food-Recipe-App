import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.color,
    required this.id,
  }) : super(key: key);

  //Navigator
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );

    /*
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoryMealsScreen(
            categoryId: id,
            categoryTitle: title,
          );
        },
      ),
  */
  }

  @override
  Widget build(BuildContext context) {
    //card for gridItems look
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
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
