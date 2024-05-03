import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/string_constants.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/auth/presentation/pages/login_page.dart';
import 'package:live_football_stats/features/auth/presentation/pages/otp_page.dart';
import 'package:live_football_stats/features/auth/presentation/pages/phone_login_page.dart';
import 'package:live_football_stats/features/intro/domain/usecase/check_first_time_open.dart';
import 'package:live_football_stats/features/intro/presentation/page/intro_page.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/favourite/favourite_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/favourite/list_favourite_league_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/all_league_of_country_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/all_league_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/live_score/live_score_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/match_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/matches/matches_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/profile/account_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/profile/profile_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_main_view.dart';

import '../../features/main_feature/presentation/pages/favourite/list_favourite_team_page.dart';
import '../app/root_page.dart';

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();
GoRouter goRouter = GoRouter(
  navigatorKey: mainNavigatorKey,
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      // builder: (context, state) => IntroPage(),
      redirect: (context, state) async {
        bool? isFirst =
            await sl.get<CheckFirstTimeOpen>().checkIfUserLoggedIn();
        if (isFirst != null && isFirst == true) {
          return '/root';
        } else {
          return "/intro";
        }
      },
    ),
    GoRoute(
      path: '/root',
      name: AppRoutesName.root,
      builder: (context, state) {
        return const RootPage();
      },
      redirect: (context, state) async {
        var box = await Hive.openBox<bool>(StringConstants.guestBoxKey);
        bool? isGuest = box.get(StringConstants.guestKey);
        if (isGuest != null && isGuest == true) {
          return '/main_view';
        }
      },
    ),
    GoRoute(
      path: '/intro',
      builder: (context, state) => IntroPage(),
      // redirect: (context, state) async {
      //   bool? isFirst =
      //       await sl.get<CheckFirstTimeOpen>().checkIfUserLoggedIn();
      //   if (isFirst != null && isFirst == true) {
      //     return "/main_view";
      //   } else {
      //     return "/intro";
      //   }
      // },
    ),
    GoRoute(
      path: '/main_view',
      builder: (context, state) => MainView(),
      name: AppRoutesName.mainView,
      routes: [
        GoRoute(
          path: 'matches_view',
          name: AppRoutesName.matchesView,
          builder: (context, state) => MatchesMainView(),
          routes: [
            GoRoute(
              path: 'match_page/:id',
              name: AppRoutesName.matchPage,
              builder: (BuildContext context, GoRouterState state) {
                final String? matchIdStr = state.pathParameters['id'];
                final int? matchID = int.tryParse(matchIdStr ?? '');
                return MatchPage(matchId: matchID!);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'live_score_view',
          name: AppRoutesName.liveScoreView,
          builder: (context, state) => const LiveScoreMainView(),
        ),
        GoRoute(
          path: 'league_main_view',
          name: AppRoutesName.leagueMainView,
          builder: (context, state) => const LeagueMainView(),
          routes: [
            GoRoute(
              path: 'all_league',
              name: AppRoutesName.allLeaguePage,
              builder: (context, state) => const AllLeaguePage(),
            ),
            GoRoute(
              path: 'leagues_of_country',
              name: AppRoutesName.leaguesOfCountry,
              builder: (context, state) {
                final country = state.extra as Country;
                return AllLeagueOfCountryPage(country: country);
              },
            ),
            GoRoute(
              path: 'league_page',
              name: AppRoutesName.leaguePage,
              builder: (context, state) {
                final leagueID = state.extra as int;
                return LeaguePage(leagueId: leagueID);
              },
            ),
          ],
        ),
        GoRoute(
            path: 'favourite_page',
            name: AppRoutesName.favouritePage,
            builder: (context, state) => const FavouritePage(),
            routes: [
              GoRoute(
                name: AppRoutesName.listFavouriteLeaguePage,
                path: 'list_favourite_league_page',
                builder: (context, state) => const ListFavouriteLeaguePage(),
              ),
              GoRoute(
                name: AppRoutesName.listFavouriteTeamPage,
                path: 'list_favourite_team_page',
                builder: (context, state) => const ListFavouriteTeamPage(),
              ),
            ]),
        GoRoute(
          path: 'account_page',
          name: AppRoutesName.accountPage,
          builder: (context, state) => const AccountPage(),
          routes: [
            GoRoute(
              name: AppRoutesName.profilePage,
              path: 'profile_page',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        GoRoute(
          path: 'team_page',
          name: AppRoutesName.teamPage,
          builder: (context, state) {
            final teamId = state.extra as int;
            return TeamMainView(teamID: teamId);
          },
        ),
      ], //
    ),
    GoRoute(
        path: '/login_page',
        name: AppRoutesName.loginPage,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'login_phone_page',
            name: AppRoutesName.loginPhonePage,
            builder: (context, state) {
              return const PhoneLoginPage();
            },
          ),
          GoRoute(
            path: 'otp_page',
            name: AppRoutesName.otpPage,
            builder: (context, state) {
              final verificationId = state.extra as String;

              return OTPPage(
                verificationId: verificationId,
              );
            },
          ),
        ]),
  ],
);
