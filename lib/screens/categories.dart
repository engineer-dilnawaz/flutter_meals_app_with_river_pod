import 'package:flutter/material.dart';
import 'package:flutter_meals_app_with_river_pod/data/dummy_data.dart';
import 'package:flutter_meals_app_with_river_pod/models/category.dart';
import 'package:flutter_meals_app_with_river_pod/models/meal.dart';
import 'package:flutter_meals_app_with_river_pod/screens/meals.dart';
import 'package:flutter_meals_app_with_river_pod/widgets/categories_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals =
        availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    // valid but not used commonly
    // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> MealsScreen(title: 'Something...', meals: [])));

    // most commonly used
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      children: [
        // availableCategories.map((category)=>CategoriesGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoriesGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
