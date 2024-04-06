import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';

class DividerHelper {
  DividerHelper._();
  static Widget sizedboxDivider() {
    return const SizedBox(
      height: 5,
    );
  }

  static Widget basicDivider() {
    return Divider(
      height: 1,
      color: AppColors.greyBorder,
    );
  }
}
