import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_data.dart';
import '../../../../core/constants/string_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';

class LoginWithPhoneWidget extends StatelessWidget {
  const LoginWithPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final box = await Hive.openBox<bool>(StringConstants.guestBoxKey);
        await box.put(StringConstants.guestKey, false);
        context.pushNamed(AppRoutesName.loginPhonePage);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 0.6,
              ),
              color: AppColors.secondaryColor),
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageData.phoneImage,
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Login with Phone",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          )),
    );
  }
}
