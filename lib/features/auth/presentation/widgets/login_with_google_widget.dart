import 'package:flutter/material.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_event.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_data.dart';

class LoginWithGoogleWidget extends StatelessWidget {
  const LoginWithGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        sl.get<AuthBloc>().add(SignInWithGoogle());
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
                ImageData.googleLogo,
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Login with Google",
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
