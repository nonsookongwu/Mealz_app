import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uId = Uuid();

class Category {
  const Category({required this.title, this.color = Colors.orange, required this.id});
  final String id;
  final String title;
  final Color color;
}
