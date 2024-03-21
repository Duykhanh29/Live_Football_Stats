import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/team_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_transfer_uc.dart';
import 'package:mockito/mockito.dart';

class MockGetTeamRepositories extends Mock implements TeamRepositories {}

void main() {
  MockGetTeamRepositories? mockGetTeamRepositories;
  GetTransferUseCase? getTransferUseCase;
  setUp(() {
    mockGetTeamRepositories = MockGetTeamRepositories();
    getTransferUseCase =
        GetTransferUseCase(teamRepositories: mockGetTeamRepositories!);
  });
  int testId = 4883;
  Transfer transfer = Transfer(
      id: 222,
      name: "fad",
      transfers: Transfers(transfersIn: [
        TransfersInElement(
            playerId: 2121,
            playerName: "fdaf",
            transferDate: "21-02-2023",
            transferType: TransferType.FREE,
            transferAmount: 455555,
            transferCurrency: "USD")
      ], transfersOut: []));
  test("Should get player from team repository", () async {
    // arrange
    when(mockGetTeamRepositories!.getTransferByTeamID(testId))
        .thenAnswer((realInvocation) async => Right(transfer));
    //act
    final result = await getTransferUseCase!.call(testId);
    //assert
    expect(result, Right(transfer));
    verify(mockGetTeamRepositories!.getTransferByTeamID(testId));
    verifyNoMoreInteractions(mockGetTeamRepositories);
  });
}
