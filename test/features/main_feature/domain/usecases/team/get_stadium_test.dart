import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stadium.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_stadium_uc.dart';
import 'package:mockito/mockito.dart';

class MockGetTeamRepositories extends Mock implements TeamRepositories {}

void main() {
  MockGetTeamRepositories? mockGetTeamRepositories;
  GetStadiumUseCase? getStadiumUseCase;
  setUp(() {
    mockGetTeamRepositories = MockGetTeamRepositories();
    getStadiumUseCase =
        GetStadiumUseCase(teamRepositories: mockGetTeamRepositories!);
  });
  int testId = 4883;
  Stadium stadium = Stadium(id: 222, name: "Santiago", city: "Lodon");
  test("Should get stadium from team repository", () async {
    // arrange
    when(mockGetTeamRepositories!.getStadiumByID(testId))
        .thenAnswer((realInvocation) async => Right(stadium));
    //act
    final result = await getStadiumUseCase!.call(testId);
    //assert
    expect(result, Right(stadium));
    verify(mockGetTeamRepositories!.getStadiumByID(testId));
    verifyNoMoreInteractions(mockGetTeamRepositories);
  });
}
