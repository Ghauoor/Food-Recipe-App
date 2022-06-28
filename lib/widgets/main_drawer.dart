import 'package:flutter/material.dart';


import '../screens/filters_screen.dart';



class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
      BuildContext ctx, String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 21,
            fontWeight: FontWeight.bold),
      ),
      //...
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.pink,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
            context,
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            context,
            'Filters',
            Icons.settings,
            () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
