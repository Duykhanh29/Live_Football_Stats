import 'package:go_router/go_router.dart';
import 'package:live_football_stats/features/auth/presentation/pages/login_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/favourite/favourite_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/live_score/live_score_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/matches/matches_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/profile/account_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/profile/profile_page.dart';

GoRouter goRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (context, state) => MainView(), routes: [
      // GoRoute(
      //   path: '/matches_view',
      //   builder: (context, state) => MatchesMainView(),
      // ),
      // GoRoute(
      //   path: '/live_score_view',
      //   builder: (context, state) => const LiveScoreMainView(),
      // ),
      // GoRoute(
      //   path: '/favourite_page',
      //   builder: (context, state) => const FavouritePage(),
      // ),
      // GoRoute(
      //   path: '/account_page',
      //   builder: (context, state) => const AccountPage(),
      // ),
      // GoRoute(
      //   path: '/profile_page',
      //   builder: (context, state) => const ProfilePage(),
      // ),
    ]),
    GoRoute(
      path: '/login_view',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
