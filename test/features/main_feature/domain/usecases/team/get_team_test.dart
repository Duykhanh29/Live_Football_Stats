import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_team_uc.dart';
import 'package:mockito/mockito.dart';

class MockGetTeamRepositories extends Mock implements TeamRepositories {}

void main() {
  MockGetTeamRepositories? mockGetTeamRepositories;
  GetTeamUseCase? getTeamUseCase;
  setUp(() {
    mockGetTeamRepositories = MockGetTeamRepositories();
    getTeamUseCase = GetTeamUseCase(teamRepositories: mockGetTeamRepositories!);
  });
  int testId = 4883;
  Team team = Team(
      country: Country(id: 60, name: "Spain"),
      id: 4883,
      isNation: false,
      name: "Real Madrid",
      stadium: StadiumResponse(
          id: 1179, name: "Estadio Santiago Bernabeu", city: "Madrid"));
  test("Should get team from team repository", () async {
    // arrange
    when(mockGetTeamRepositories!.getTeamByID(testId))
        .thenAnswer((realInvocation) async => Right(team));
    //act
    final result = await getTeamUseCase!.call(testId);
    //assert
    expect(result, Right(team));
    verify(mockGetTeamRepositories!.getTeamByID(testId));
    verifyNoMoreInteractions(mockGetTeamRepositories);
  });
}
