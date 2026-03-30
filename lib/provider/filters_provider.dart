import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegeterian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegeterian: false,
        Filter.vegan: false,
      });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isChecked) {
    state = {...state, filter: isChecked};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filterResult = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (filterResult[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filterResult[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filterResult[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (filterResult[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();

});
