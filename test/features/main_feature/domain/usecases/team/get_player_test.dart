import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_player_uc.dart';
import 'package:mockito/mockito.dart';

class MockGetTeamRepositories extends Mock implements TeamRepositories {}

void main() {
  MockGetTeamRepositories? mockGetTeamRepositories;
  GetPlayerUseCase? getPlayerUseCase;
  setUp(() {
    mockGetTeamRepositories = MockGetTeamRepositories();
    getPlayerUseCase =
        GetPlayerUseCase(teamRepositories: mockGetTeamRepositories!);
  });
  int testId = 4883;
  Player player = Player(id: 22222, name: "oke");
  test("Should get player from team repository", () async {
    // arrange
    when(mockGetTeamRepositories!.getPlayerByID(testId))
        .thenAnswer((realInvocation) async => Right(player));
    //act
    final result = await getPlayerUseCase!.call(testId);
    //assert
    expect(result, Right(player));
    verify(mockGetTeamRepositories!.getPlayerByID(testId));
    verifyNoMoreInteractions(mockGetTeamRepositories);
  });
}
