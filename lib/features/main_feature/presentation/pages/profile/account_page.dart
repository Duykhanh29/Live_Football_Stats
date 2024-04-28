import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/constants/image_data.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/themes/themes_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/profile/general_widget_view.dart';

import '../../blocs/nav_bar/nav_bar_cubit.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        // title: Text(
        //   "Account",
        //   style: AppTextStyles.appBarTexStyle(),
        // ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.2),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // avatar
                    if (state is AuthorizedState)
                      StreamBuilder(
                        stream: sl.get<AuthBloc>().currentUser,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            UserEntity user = snapshot.data!;
                            if (user.photo != null) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColors.sencondaryBorder,
                                backgroundImage: NetworkImage(user.photo!),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColors.sencondaryBorder,
                                backgroundImage:
                                    const AssetImage(ImageData.circleAvatar),
                              );
                            }
                          } else {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.sencondaryBorder,
                              backgroundImage:
                                  const AssetImage(ImageData.circleAvatar),
                            );
                          }
                        },
                      ),
                    if (state is! AuthorizedState)
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.sencondaryBorder,
                        backgroundImage:
                            const AssetImage(ImageData.circleAvatar),
                      ),

                    //name
                    if (state is AuthorizedState)
                      StreamBuilder(
                        stream: sl.get<AuthBloc>().currentUser,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data != null) {
                              UserEntity userEntity = snapshot.data!;
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                child: Text(
                                  userEntity.userName ?? "",
                                  style: AppTextStyles.headingTextStyle(),
                                ),
                              );
                            } else {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                child: Text(
                                  "",
                                  style: AppTextStyles.headingTextStyle(),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              child: Text(
                                "...",
                                style: AppTextStyles.headingTextStyle(),
                              ),
                            );
                          }
                        },
                      ),
                    if (state is! AuthorizedState)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        child: Text(
                          "Not logged in yet",
                          style: AppTextStyles.headingTextStyle(),
                        ),
                      ),

                    // button to login
                    if (state is! AuthorizedState)
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutesName.loginPage);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: AppColors.eventColor1,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            "Login",
                            style: AppTextStyles.commonTextStyle(),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: BlocConsumer<NavbarCubit, int>(
          builder: (context, state) {
            if (state == 4) {
              return BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocBuilder<ThemesCubit, bool>(
                          builder: (context, state) => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.appBorder,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SwitchListTile(
                              dense: true,
                              value: state,
                              onChanged: (value) async {
                                await context
                                    .read<ThemesCubit>()
                                    .changeTheme(value);
                              },
                              activeColor: AppColors.cardColor,
                              title: Text(state ? "ON" : "OFF"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const GeneralWidgetView(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is AuthorizedState)
                          InkWell(
                            onTap: () async {
                              sl.get<AuthBloc>().add(SignOut());
                            },
                            splashColor: AppColors.liveColor,
                            focusColor: AppColors.secondaryColor,
                            hoverColor: AppColors.cardColor,
                            highlightColor: AppColors.thirdColor,
                            child: ListTile(
                              leading: const Icon(
                                Ionicons.log_out,
                                color: AppColors.warningColor,
                              ),
                              title: Text(
                                "LogOut",
                                style: AppTextStyles.warningTextStyle(),
                              ),
                              // onTap: () async {
                              //   sl.get<AuthBloc>().add(SignOut());
                              // },
                            ),
                          ),
                      ],
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is UnauthorizedState) {
                    context.goNamed(AppRoutesName.loginPage);
                  }
                },
                listenWhen: (previous, current) {
                  if (previous is AuthorizedState) {
                    return true;
                  } else {
                    return false;
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
          listener: (context, state) {
            if (state != 4) {
              EasyLoading.dismiss();
            }
          },
        ),
      ),
    );
  }
}
