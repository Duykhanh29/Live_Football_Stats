import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/main_favourite_view.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../blocs/nav_bar/nav_bar_cubit.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          "Following",
          style: AppTextStyles.appBarTexStyle(),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<NavbarCubit, int>(
        builder: (context, state) {
          if (state == 3) {
            return BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthorizedState) {
                  return MainFavouriteView(
                    uid: state.user!.userID!,
                  );
                } else if (state is UnauthorizedState) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "To access this feature, you first need to log in",
                            style: AppTextStyles.commonTextStyle(),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.pushNamed(AppRoutesName.loginPage);
                          },
                          splashColor: AppColors.darkBackgroundColor,
                          focusColor: AppColors.secondaryColor,
                          hoverColor: AppColors.cardColor,
                          highlightColor: AppColors.thirdColor,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.eventColor1,
                                borderRadius: BorderRadius.circular(5)),
                            // width: MediaQuery.of(context).size.width * 0.65,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              "Login",
                              style: AppTextStyles.headingTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
              listener: (context, state) {
                if (state is LoadingState) {
                  EasyLoading.show();
                } else {
                  EasyLoading.dismiss();
                }
              },
            );
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state != 3) {
            EasyLoading.dismiss();
          }
        },
      ),
    );
  }
}
