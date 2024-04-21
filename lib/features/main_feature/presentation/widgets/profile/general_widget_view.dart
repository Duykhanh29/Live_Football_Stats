import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';

class GeneralWidgetView extends StatelessWidget {
  const GeneralWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.appBorder, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 30,
            // decoration: BoxDecoration(
            //   color: AppColors.lighterCardColor,
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(15),
            //     topRight: Radius.circular(15),
            //   ),
            // ),
            child: Text(
              "Support",
              style: AppTextStyles.headingTextStyle(),
            ),
          ),
          Divider(
            height: 1,
            color: AppColors.greyBorder,
          ),
          ListTile(
            leading: Icon(
              Ionicons.share_social,
              color: AppColors.backgroundColor,
            ),
            title: Text(
              "Share",
              style: AppTextStyles.commonTextStyle(),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.backgroundColor,
              size: 18,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: AppColors.backgroundColor,
            ),
            title: Text(
              "Contact us",
              style: AppTextStyles.commonTextStyle(),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.backgroundColor,
              size: 18,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Ionicons.share_social,
              color: AppColors.backgroundColor,
            ),
            title: Text(
              "Help centre",
              style: AppTextStyles.commonTextStyle(),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.backgroundColor,
              size: 18,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
