import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_leagues_of_country_uc.dart';
import 'package:mockito/mockito.dart';

class MockLeagueRepositories extends Mock implements LeagueRepositories {}

void main() {
  late MockLeagueRepositories mockLeagueRepositories;
  late GetLeagueOfCountryUseCase getLeagueOfCountryUseCase;
  setUp(() {
    mockLeagueRepositories = MockLeagueRepositories();
    getLeagueOfCountryUseCase =
        GetLeagueOfCountryUseCase(mockLeagueRepositories);
  });
  int testId = 60;
  List<League> actualListLeague = [
    League(
        country: Country(id: 60, name: "Spain"),
        id: 297,
        name: "La liga",
        isCup: true),
    League(
        country: Country(id: 60, name: "Spain"),
        id: 298,
        name: "La liga 1",
        isCup: true),
  ];
  test("should get leagues from country id", () async {
    // arrange
    when(mockLeagueRepositories.getLeaguesByCountryId(testId))
        .thenAnswer((realInvocation) async => Right(actualListLeague));

    // act
    final result = await getLeagueOfCountryUseCase.call(testId);
    // assert
    expect(result, Right(actualListLeague));
    verify(mockLeagueRepositories.getLeaguesByCountryId(testId));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockLeagueRepositories);
  });
}
