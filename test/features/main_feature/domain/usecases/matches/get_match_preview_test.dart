import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_preview_uc.dart';
import 'package:mockito/mockito.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';

class MockMatchRepositories extends Mock implements MatchRepositories {}

void main() {
  late GetMatchPreviewUseCase getMatchPreviewUseCase;
  late MockMatchRepositories mockMatchRepositories;
  setUp(() {
    mockMatchRepositories = MockMatchRepositories();
    getMatchPreviewUseCase =
        GetMatchPreviewUseCase(matchRepositories: mockMatchRepositories);
  });
  MatchPreview matchPreview = MatchPreview(
      id: 123,
      date: "23r4",
      time: "324",
      wordCount: 234,
      country: Country(id: 23, name: "name"),
      league: LeagueResponse(id: 23456, name: "name"),
      stage: StageResponse(id: 1234, name: "name", isActive: false),
      teams: Teams(
          home: TeamResponse(id: 765, name: "name"),
          away: TeamResponse(id: 87, name: "name")),
      matchData: MatchData(
          weather: Weather(tempF: 34, tempC: 32, description: "description"),
          excitementRating: 12,
          prediction: Prediction(type: "type", choice: "choice")),
      previewContent: [PreviewContent(name: "name", content: "GOOD")]);
  int testId = 123;
  test("should get preview match from repository", () async {
    // arrange
    when(mockMatchRepositories.getMacthPreview(testId))
        .thenAnswer((realInvocation) async => Right(matchPreview));
    //act
    final result = await getMatchPreviewUseCase.call(testId);

    // assert
    expect(result, Right(matchPreview));
    verify(mockMatchRepositories.getMacthPreview(testId));
    verifyNoMoreInteractions(mockMatchRepositories);
  });
}
