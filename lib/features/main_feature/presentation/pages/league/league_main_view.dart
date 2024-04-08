import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/all_league_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/list_league_widget.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/top_leagues_widget.dart';

class LeagueMainView extends StatelessWidget {
  const LeagueMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          "Leagues",
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      body: BlocBuilder<NavbarCubit, int>(
        builder: (context, state) {
          if (state == 2) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                        child: Text(
                          "Top leagues",
                          style: AppTextStyles.headingTextStyle(),
                        )),
                  ),
                  TopLeaguesWidget(),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 5, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(AppRoutesName.allLeaguePage);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) {
                              //     return const AllLeaguePage();
                              //   },
                              // ));
                            },
                            child: const Text(
                              "See all league",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                        child: Text(
                          "All country",
                          style: AppTextStyles.headingTextStyle(),
                        )),
                  ),
                  const ListLeagueWidget(),
                ],
              ),
              //  Column(
              //   children: [
              //     // Expanded(child: TopLeaguesWidget()),
              //     //
              //     const Expanded(child: ListLeagueWidget()),
              //   ],
              // ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
