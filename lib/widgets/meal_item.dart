import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // final Function removeItem;

  const MealItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    // required this.removeItem,
  }) : super(key: key);

  //getter for enums
  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;

      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unkonwn';
    }
  }

  String get aaffordabilitytext {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;

      case Affordability.Pricey:
        return 'Pricey';
        break;
      default:
        return 'Unkonwn';
    }
  }

  //Getting data form pages.. -->
  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          MealDetailScreen.routeName,
          arguments: id,
        )
        .then(
          (result) => {
            if (result != null)
              {
                //  removeItem(result),
              },
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => selectMeal(context)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5 / 0.5),
                      color: Colors.black54,
                    ),
                    width: 300.0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.attach_money),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(aaffordabilitytext),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
