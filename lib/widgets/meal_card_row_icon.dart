import 'package:flutter/material.dart';

class MealItemIconRow extends StatelessWidget {
  const MealItemIconRow({super.key, required this.iconText, required this.text});

  final IconData iconText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconText, size: 17, color: Colors.white,),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ],
    );
  }
}
