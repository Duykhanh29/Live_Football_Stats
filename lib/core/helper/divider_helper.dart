import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';

class DividerHelper {
  DividerHelper._();
  static Widget sizedboxDivider({double? height}) {
    return SizedBox(
      height: height ?? 5,
    );
  }

  static Widget basicDivider() {
    return Divider(
      height: 1,
      color: AppColors.greyBorder,
    );
  }

  static Widget headingDivider(String header) {
    return Container(
      // padding: const EdgeInsets.only(left: 15, bottom: 10, top: 20),
      margin: EdgeInsets.only(left: 5, bottom: 10, top: 10),
      decoration: BoxDecoration(color: Colors.red),
      // height: 15,
      // alignment: Alignment.centerLeft,
      child: Text(
        header,
        style: AppTextStyles.headingTextStyle(),
      ),
    );
  }
}
