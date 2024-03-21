import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_country_uc.dart';
import 'package:mockito/mockito.dart';

class MockLeagueRepositories extends Mock implements LeagueRepositories {}

void main() {
  late MockLeagueRepositories mockLeagueRepositories;
  late GetAllCountryUseCase getAllCountryUseCase;
  setUp(() {
    mockLeagueRepositories = MockLeagueRepositories();
    getAllCountryUseCase = GetAllCountryUseCase(mockLeagueRepositories);
  });
  List<Country> actualListCountry = [
    Country(id: 60, name: "Spain"),
    Country(id: 61, name: "England"),
    Country(id: 62, name: "Italia")
  ];
  test("Should get list country from repository ", () async {
    // arrange
    when(mockLeagueRepositories.getListCountry())
        .thenAnswer((realInvocation) async => Right(actualListCountry));
    // act
    final result = await getAllCountryUseCase.call();
    // assert
    expect(result, Right(actualListCountry));
  });
}
