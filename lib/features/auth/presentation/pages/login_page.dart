import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/utils/validators.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_state.dart';
import 'package:live_football_stats/features/auth/presentation/widgets/login_with_google_widget.dart';

import '../../../../core/constants/image_data.dart';
import '../widgets/login_with_fb_widget.dart';
import '../widgets/login_with_phone_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! UnauthorizedState || state is! ErrorAuthState) {
            return SingleChildScrollView(
              child: Form(
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 68,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        ImageData.appLogo,
                        height: 100,
                        width: 120,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Welcome to Live Football Stats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 80),
                      const LoginWithGoogleWidget(),
                      const SizedBox(height: 8),
                      const LoginWithFacebookWidget(),
                      const SizedBox(height: 8),
                      const LoginWithPhoneWidget(),
                      const SizedBox(height: 80),
                      //_buildOrLine(context),
                      loginAsGuest(context),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state is AuthorizedState) {
            GoRouter.of(context).goNamed(AppRoutesName.mainView);
          } else if (state is ErrorAuthState) {
            EasyLoading.showError(state.message ?? "An error has occurred");
          }
        },
      ),
    );
  }
}

/// Section Widget
Widget _buildOrLine(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 9,
          ),
          child: SizedBox(
            width: 100,
            child: Divider(
              color: AppColors.appBorder,
              height: 0.4,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          "Or",
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 9,
          ),
          child: SizedBox(
            width: 100,
            child: Divider(
              color: AppColors.appBorder,
              height: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget loginAsGuest(BuildContext context) {
  return GestureDetector(
    onTap: () => context.goNamed(AppRoutesName.mainView),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.thirdColor),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        "Login as Guest",
        style: AppTextStyles.commonTextStyle(),
      ),
    ),
  );
}
