import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_country_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_leagues_uc.dart';
import 'package:mockito/mockito.dart';

class MockLeagueRepositories extends Mock implements LeagueRepositories {}

void main() {
  late MockLeagueRepositories mockLeagueRepositories;
  late GetAllLeaguesUseCase getAllCountryUseCase;
  setUp(() {
    mockLeagueRepositories = MockLeagueRepositories();
    getAllCountryUseCase = GetAllLeaguesUseCase(mockLeagueRepositories);
  });
  List<League> actualAllLeague = [
    League(
        country: Country(id: 60, name: "spain"),
        id: 297,
        name: "La Liga",
        isCup: false),
    League(
        country: Country(id: 60, name: "spain"),
        id: 298,
        name: "La Liga 1",
        isCup: false),
    League(
        country: Country(id: 60, name: "spain"),
        id: 298,
        name: "La Liga 2",
        isCup: false),
  ];
  test("Should get all league from repository ", () async {
    // arrange
    when(mockLeagueRepositories.getAllLeague())
        .thenAnswer((realInvocation) async => Right(actualAllLeague));
    // act
    final result = await getAllCountryUseCase.call();
    // assert
    expect(result, Right(actualAllLeague));
  });
}
