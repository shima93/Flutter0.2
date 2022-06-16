import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.amber.shade200,
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover)),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                      color: Theme.of(context).cardColor,
                      child: Text(selectedMeal.ingredients[index]),
                    )),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainer(ListView.builder(
            itemCount: selectedMeal.steps.length,
            itemBuilder: (ctx, index) => Column(
              children: [
                ListTile(
                  leading: CircleAvatar(child: Text('# ${(index + 1)}')),
                  title: Text(selectedMeal.steps[index]),
                ),
                Divider()
              ],
            ),
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: toggleFavorite,
      ),
    );
  }
}
