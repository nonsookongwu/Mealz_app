import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screen_widgets/filters_screen.dart';
import 'package:meals_app/screen_widgets/meals_widget.dart';
import 'package:meals_app/widgets/category_item.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.onSelectmeal,
    required this.filterResult,
  });

  final void Function(Meal meal) onSelectmeal;
  final Map<Filter, bool> filterResult;

  void _handleNavigateMeals(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((meal) {
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

    // print("filteredResult is $filterResult");
    // print("filteredMeal is $filteredMeals");

    final availableMeal = filteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsWidget(
          meals: availableMeal,
          title: category.title,
          onSelectmeal: onSelectmeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...availableCategories.map(
            (category) => CategoryItem(
              category: category,
              onSelectCategory: () => _handleNavigateMeals(context, category),
            ),
          ),
        ],
      ),
    );
  }
}
