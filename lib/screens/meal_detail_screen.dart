import 'package:flutter/material.dart';

import '../models/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function togglefavorite;
  final Function isFavorite;

  const MealDetailScreen({
    Key? key,
    required this.togglefavorite,
    required this.isFavorite,
  }) : super(key: key);

  //Builder Method for Handling texts in details screen -->
  Widget buildSelectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 10.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      height: 150,
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Recieving the Data coming through arg -->
    final mealId = ModalRoute.of(context)?.settings.arguments as String;

    //filter the food -->
    final selectedMeal = dUMMYMEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Handling Image -->
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            // --->
            buildSelectionTitle(
              context,
              'Ingredients',
            ),
            //List of Ingredients -->
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ),
            buildSelectionTitle(
              context,
              'Steps',
            ),
            buildContainer(
              ListView.builder(
                itemBuilder: ((cxt, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              '# ${(index + 1)}',
                            ),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .copyWith()
                                .primary,
                          ),
                          title: Text(
                            selectedMeal.steps[index],
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .copyWith()
                                .primary),
                      ],
                    )),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => togglefavorite(mealId),
        child:  Icon(
           isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
