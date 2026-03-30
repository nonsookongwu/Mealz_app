import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screen_widgets/meals_widget.dart';
import 'package:meals_app/widgets/category_item.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  // final Map<Filter, bool> filterResult;

  void _handleNavigateMeals(
    BuildContext context,
    Category category,
    WidgetRef ref,
  ) {
    final filteredMeals = ref.watch(filteredMealsProvider);

    final availableMeal = filteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealsWidget(meals: availableMeal, title: category.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onSelectCategory: () =>
                  _handleNavigateMeals(context, category, ref),
            ),
          ),
        ],
      ),
    );
  }
}
