import 'package:flutter/material.dart';

import 'package:flutter_meals_app_with_river_pod/providers/favourites_provider.dart';
import 'package:flutter_meals_app_with_river_pod/providers/filters_provider.dart';
import 'package:flutter_meals_app_with_river_pod/providers/meal_provider.dart';
import 'package:flutter_meals_app_with_river_pod/screens/categories.dart';

import 'package:flutter_meals_app_with_river_pod/screens/filters.dart';
import 'package:flutter_meals_app_with_river_pod/screens/meals.dart';
import 'package:flutter_meals_app_with_river_pod/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // Navigator.of(
      //   context,
      // ).pushReplacement(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
      Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals =
        meals.where((meal) {
          if (activeFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (activeFilters[Filters.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (activeFilters[Filters.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeal = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(meals: favouriteMeal);
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
