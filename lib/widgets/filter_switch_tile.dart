import 'package:flutter_meals_app_with_river_pod/providers/filters_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSwitchTile extends ConsumerWidget {
  const FilterSwitchTile({
    super.key,
    required this.titleText,
    required this.type,
  });

  final String titleText;
  final Filters type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return SwitchListTile(
      value: activeFilters[type]!,
      onChanged: (value) {
        ref.read(filtersProvider.notifier).setFilter(type, value);
      },
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        'Only include ${titleText.toLowerCase()} meals.',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: EdgeInsets.only(left: 34.0, right: 22.0),
    );
  }
}
