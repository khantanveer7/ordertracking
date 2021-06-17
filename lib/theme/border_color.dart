import 'package:flutter/material.dart';

Color getTagColor(String tags) {
  switch (tags) {
    case 'food':
      return Colors.purple;
    case 'starter':
      return Colors.orange;
    case 'main course':
      return Colors.grey;
    default:
      return Colors.black;
  }
}
