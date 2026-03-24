import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uID = Uuid();

enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

const complexityIcons = {
  Complexity.simple: Icons.business_center,
  Complexity.hard: Icons.account_balance,
  Complexity.challenging: Icons.change_circle_outlined,
};

final affordabilityIcons = {
  Affordability.affordable: Icons.money_off_csred_rounded,
  Affordability.pricey: Icons.attach_money,
  Affordability.luxurious: Icons.diamond_sharp
};

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
}
