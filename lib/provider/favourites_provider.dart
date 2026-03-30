import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/models/meals.dart';

class FavouritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavouritesMealsNotifier() : super([]);

  bool toggleFavouriteMealsStatus(Meal meal) {
    // state is a global variable that represents the previous state
    final mealExists = state.contains(meal);

    if (mealExists) {
      state = state.where((item) => item.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouritesMealsNotifier, List<Meal>>((ref) {
      return FavouritesMealsNotifier();
    });
