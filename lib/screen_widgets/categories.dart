import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/screen_widgets/meals_widget.dart';
import 'package:meals_app/widgets/category_item.dart';

class Categories extends ConsumerStatefulWidget {
  const Categories({super.key});

  @override
  ConsumerState<Categories> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends ConsumerState<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),

      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(top: (100 - _animationController.value * 100)),
      //   child: child,
      // ),
    );
  }
}
