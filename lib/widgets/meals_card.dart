import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screen_widgets/meal_detail_screen.dart';
import 'package:meals_app/widgets/meal_card_row_icon.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsCard extends StatelessWidget {
  const MealsCard({super.key, required this.meal});

  final Meal meal;

  // String get complexityText {
  //   return meal.complexity.name[0].toUpperCase() +
  //       meal.complexity.name.substring(1);
  // }

  String capitalizeText(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  void _handleNavigateMealDetail(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => MealDetailScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => _handleNavigateMealDetail(context, meal),
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                color: const Color.fromARGB(167, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      meal.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 15,
                      children: [
                        MealItemIconRow(
                          iconText: Icons.access_time,
                          text: "${meal.duration} mins",
                        ),
                        MealItemIconRow(
                          iconText: Icons.work,
                          text: capitalizeText(meal.complexity.name),
                          // text: meal.complexity.name,
                        ),
                        MealItemIconRow(
                          iconText: Icons.attach_money,
                          text: capitalizeText(meal.affordability.name),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
