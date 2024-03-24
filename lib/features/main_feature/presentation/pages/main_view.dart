import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/favourite/favourite_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/table_of_league_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/live_score/live_score_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/match_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/profile/account_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_main_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});
  final List<Widget> screens = [
    LeagueMainView(),
    LiveScoreMainView(),
    // MatchPage(),
    TeamMainView(),
    FavouritePage(),
    AccountPage(),
  ];
  final List<PersistentBottomNavBarItem> _navBarsItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.live_tv_rounded),
      title: "Live",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.event_available_rounded),
      title: "Matches",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.emoji_events_rounded),
      title: "Leagues",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.star_border_rounded),
      title: "Favourite",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_2_rounded),
      title: "Profile",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    ),
  ];
  PersistentTabController? _controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state) {
        return PersistentTabView(
          context,
          items: _navBarsItems,
          screens: screens,
          controller: context.read<NavbarCubit>().pageController,
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: false,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          onItemSelected: (value) {
            context.read<NavbarCubit>().updateIndex(value);
          },
          popAllScreensOnTapAnyTabs: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
        );
      },
    );
  }
}
