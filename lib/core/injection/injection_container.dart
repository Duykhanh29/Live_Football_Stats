import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/core/utils/dio_client.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/league_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/live_score_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/matches_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/table_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/team_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/repositories/league_repo.dart';
import 'package:live_football_stats/features/main_feature/data/repositories/live_score_repo.dart';
import 'package:live_football_stats/features/main_feature/data/repositories/match_repo.dart';
import 'package:live_football_stats/features/main_feature/data/repositories/table_repo.dart';
import 'package:live_football_stats/features/main_feature/data/repositories/team_repo.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/table_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_country_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_leagues_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_country_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_leagues_of_country_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_list_live_matches_of_a_stage_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_list_stage_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_live_match_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_live_score_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_current_matches_of_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_head_to_head_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_preview_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_by_date_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_of_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_upcoming_matches_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/table/get_table_of_a_league_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_player_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_stadium_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_team_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_transfer_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/country_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/preview_match/preview_match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/player/player_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // _initAuth();

  // network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerFactory<Dio>(() => Dio());
  // data sources
  sl.registerLazySingleton<LeagueRemoteDataSource>(
      () => LeagueRemoteDataSourceImpl(dio: sl(), dioClient: sl()));
  sl.registerLazySingleton<LiveScoreRemoteDataSource>(
      () => LiveScoreRemoteDataSourceImpl(dio: sl(), dioClient: sl()));
  sl.registerLazySingleton<MatchRemoteDataSource>(
      () => MatchRemoteDataSourceImpl(dio: sl(), dioClient: sl()));
  sl.registerLazySingleton<TableRemoteDataSource>(
      () => TableRemoteDataSourceImpl(dio: sl(), dioClient: sl()));
  sl.registerLazySingleton<TeamRemoteDataSource>(
      () => TeamRemoteDataSourceImpl(dio: sl(), dioClient: sl()));

  // repositories
  sl.registerLazySingleton<LeagueRepositories>(
      () => LeagueRepoImpl(leagueRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<LiveScoreRepositories>(() =>
      LiveScoreRepoImpl(liveScoreRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TeamRepositories>(
      () => TeamRepoImpl(networkInfo: sl(), teamRemoteDataSource: sl()));
  sl.registerLazySingleton<TableRepositories>(
      () => TableRepoIplm(networkInfo: sl(), tableRemoteDataSource: sl()));
  sl.registerLazySingleton<MatchRepositories>(
      () => MatchRepoImpl(matchRemoteDataSource: sl(), networkInfo: sl()));

  // usecases
  sl.registerLazySingleton<GetAllLeaguesUseCase>(
      () => GetAllLeaguesUseCase(sl()));
  sl.registerLazySingleton<GetLeagueOfCountryUseCase>(
      () => GetLeagueOfCountryUseCase(sl()));
  sl.registerLazySingleton<GetAllCountryUseCase>(
      () => GetAllCountryUseCase(sl()));
  sl.registerLazySingleton<GetCountryUseCase>(() => GetCountryUseCase(sl()));
  sl.registerLazySingleton<GetLeagueUseCase>(() => GetLeagueUseCase(sl()));

  sl.registerLazySingleton<GetLiveScoreUseCase>(
      () => GetLiveScoreUseCase(liveScoreRepositories: sl()));
  sl.registerLazySingleton<GetListStageUseCase>(
      () => GetListStageUseCase(liveScoreRepositories: sl()));
  sl.registerLazySingleton<GetListLiveMatchesOfAStageUseCase>(
      () => GetListLiveMatchesOfAStageUseCase(liveScoreRepositories: sl()));
  sl.registerLazySingleton<GetLiveMatchUseCase>(
      () => GetLiveMatchUseCase(liveScoreRepositories: sl()));

  sl.registerLazySingleton<GetMatchPreviewUseCase>(
      () => GetMatchPreviewUseCase(matchRepositories: sl()));
  sl.registerLazySingleton<GetMatchUseCase>(
      () => GetMatchUseCase(matchRepositories: sl()));
  sl.registerLazySingleton<GetMatchesOfLeagueUseCase>(
      () => GetMatchesOfLeagueUseCase(matchRepositories: sl()));
  sl.registerLazySingleton<GetUpcomingMatchesUseCase>(
      () => GetUpcomingMatchesUseCase(matchRepositories: sl()));
  sl.registerLazySingleton<GetHeadToHeadUseCase>(
      () => GetHeadToHeadUseCase(matchRepositories: sl()));
  sl.registerLazySingleton<GetMatchesByDateUseCase>(
      () => GetMatchesByDateUseCase(matchRepositories: sl()));
  sl.registerLazySingleton<GetCurrentMatchesOfLeagueUseCase>(
      () => GetCurrentMatchesOfLeagueUseCase(matchRepositories: sl()));

  sl.registerLazySingleton<GetTableOfALeagueUseCase>(
      () => GetTableOfALeagueUseCase(tableRepositories: sl()));

  sl.registerLazySingleton<GetPlayerUseCase>(
      () => GetPlayerUseCase(teamRepositories: sl()));
  sl.registerLazySingleton<GetStadiumUseCase>(
      () => GetStadiumUseCase(teamRepositories: sl()));
  sl.registerLazySingleton<GetTeamUseCase>(
      () => GetTeamUseCase(teamRepositories: sl()));
  sl.registerLazySingleton<GetTransferUseCase>(
      () => GetTransferUseCase(teamRepositories: sl()));

  // blocs
  sl.registerFactory<LeaguesBloc>(
      () => LeaguesBloc(leagueOfCountryUseCase: sl(), leaguesUseCase: sl()));
  sl.registerFactory<LeagueBloc>(() => LeagueBloc(leagueUseCase: sl()));
  sl.registerFactory<MatchesBloc>(
      () => MatchesBloc(matchesOfLeagueUseCase: sl()));
  sl.registerFactory<MatchBloc>(
      () => MatchBloc(matchPreviewUseCase: sl(), matchUseCase: sl()));
  sl.registerFactory<PreviewMatchBloc>(
      () => PreviewMatchBloc(matchPreviewUseCase: sl(), matchUseCase: sl()));
  sl.registerFactory<TableBloc>(() => TableBloc(tableOfALeagueUseCase: sl()));
  sl.registerFactory<LiveScoreBloc>(
      () => LiveScoreBloc(liveMatchUseCase: sl(), liveScoreUseCase: sl()));
  sl.registerFactory<TeamBloc>(() => TeamBloc(teamUseCase: sl()));
  sl.registerFactory<PlayerBloc>(() => PlayerBloc(playerUseCase: sl()));
  sl.registerFactory<CountryBloc>(
      () => CountryBloc(allCountryUseCase: sl(), countryUseCase: sl()));
  sl.registerFactory<TransferBloc>(() => TransferBloc(transferUseCase: sl()));
  sl.registerFactory<HeadToHeadBloc>(
      () => HeadToHeadBloc(headToHeadUseCase: sl()));
  sl.registerFactory<MatchesByDateBloc>(
      () => MatchesByDateBloc(matchesByDateUseCase: sl()));
  sl.registerFactory<UpcomingMatchesBloc>(
      () => UpcomingMatchesBloc(upcomingMatchesUseCase: sl()));
}
