import 'package:flutter/material.dart';
import 'package:flutter_meals_app_with_river_pod/providers/filters_provider.dart';
import 'package:flutter_meals_app_with_river_pod/widgets/filter_switch_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Filters')),

      body: Column(
        children: [
          FilterSwitchTile(type: Filters.glutenFree, titleText: 'Gluten-free'),
          FilterSwitchTile(
            type: Filters.lactoseFree,
            titleText: 'Lactose-free',
          ),
          FilterSwitchTile(
            type: Filters.vegetarian,
            titleText: 'Vegetarian-free',
          ),
          FilterSwitchTile(type: Filters.vegan, titleText: 'Vegan-free'),
        ],
      ),
    );
  }
}
