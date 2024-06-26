import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';

class AppTextStyles {
  static TextStyle appBarTexStyle() {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  static TextStyle secondAppBarTextStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  }

  static TextStyle actionAppBarTextStyle() {
    return const TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  }

  static TextStyle tabBarTextStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
  }

  static TextStyle headingTextStyle() {
    return const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
  }

  static TextStyle commonTextStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
  }

  static TextStyle warningTextStyle() {
    return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.warningColor);
  }
}
