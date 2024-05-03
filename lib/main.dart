import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:live_football_stats/core/constants/app_routes.dart';
import 'package:live_football_stats/core/constants/app_themes.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/core/services/analystic_service/analystic_service.dart';
import 'package:live_football_stats/core/utils/format_date.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/themes/get_themes_usecase.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/country_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/country_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/preview_match/preview_match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_league_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_live_score_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/player/player_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/themes/themes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/main_feature/domain/entities/favourite/favourite_team_entity.dart';
import 'features/main_feature/presentation/blocs/favourite/favourite_team/favourite_team_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseCrashlytics.instance.crash();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  MobileAds.instance.initialize();
  // const fatalError = true;
  // Non-async exceptions
  // FlutterError.onError = (errorDetails) {
  //   if (fatalError) {
  //     // If you want to record a "fatal" exception
  //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //     // ignore: dead_code
  //   } else {
  //     // If you want to record a "non-fatal" exception
  //     FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  //   }
  // };
  // Async exceptions
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   if (fatalError) {
  //     // If you want to record a "fatal" exception
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     // ignore: dead_code
  //   } else {
  //     // If you want to record a "non-fatal" exception
  //     FirebaseCrashlytics.instance.recordError(error, stack);
  //   }
  //   return true;
  // };
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  await dotenv.load(fileName: ".env");
  await initDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteLeagueEntityAdapter());
  Hive.registerAdapter(FavouriteTeamEntityAdapter());
  Hive.registerAdapter(LeagueDataEntityAdapter());
  Hive.registerAdapter(TeamDataEntityAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        //  MaterialApp(
        //   home: MyHomePage(title: "title"),
        // );

        MultiBlocProvider(
            providers: [
          BlocProvider(
            create: (context) =>
                ThemesCubit(getThemeUseCase: sl.get<GetThemeUsecase>()),
          ),
          BlocProvider(
            create: (context) => sl.get<AuthBloc>()..add(IsLoginEvent()),
          ),
          BlocProvider(
            create: (context) => NavbarCubit(),
          ),
          BlocProvider(
            create: (context) => NavLiveScoreCubit(),
          ),
          BlocProvider(
            create: (context) => sl.get<MatchesByDateBloc>()
              ..add(MatchesByDateFetched(
                  FormatDate.dateToDateAndTime2(DateTime.now()))),
          ),
          BlocProvider(
            create: (context) =>
                sl.get<LiveScoreBloc>()..add(LiveScoreFetched()),
          ),
          BlocProvider(
            create: (context) =>
                sl.get<UpcomingMatchesBloc>()..add(UpcomingMatchesFetched()),
          ),
          BlocProvider(
            create: (context) =>
                sl.get<CountryBloc>()..add(AllCountryFetched()),
          ),
          BlocProvider(
            create: (context) => sl.get<LeaguesBloc>()..add(AllLeagueFetched()),
          ),
          BlocProvider(
            create: (context) => sl.get<FavouriteLeagueBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<FavouriteTeamBloc>(),
          ),
          BlocProvider(
            create: (context) => NavLeagueCubit(),
          ),
          BlocProvider(
            create: (context) => sl.get<LeagueBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<MatchesBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<MatchBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<PreviewMatchBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<HeadToHeadBloc>(),
          ),
          BlocProvider(create: (context) => sl.get<TableBloc>()),
          BlocProvider(
            create: (context) => sl.get<TeamBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<TransferBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<PlayerBloc>(),
          ),
        ],
            child: BlocBuilder<ThemesCubit, bool>(builder: (context, state) {
              sl.get<AnalysticService>().logAppOpen(DateTime.now());
              return MaterialApp.router(
                routerDelegate: goRouter.routerDelegate,
                routeInformationParser: goRouter.routeInformationParser,
                routeInformationProvider: goRouter.routeInformationProvider,
                debugShowCheckedModeBanner: false,
                // home: MainView(),
                themeMode: ThemeMode.system,
                theme: state
                    ? AppTheme.lightThemes
                    : AppTheme
                        .darkTheme, // applies this theme if the device theme is light mode
                darkTheme: AppTheme.darkTheme,
                builder: EasyLoading.init(),
              );
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
