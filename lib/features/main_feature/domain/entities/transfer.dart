import 'package:equatable/equatable.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class Transfer extends Equatable {
  int id;
  String name;
  Transfers transfers;

  Transfer({
    required this.id,
    required this.name,
    required this.transfers,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, transfers];
}

class Transfers extends Equatable {
  List<TransfersInElement> transfersIn;
  List<TransfersInElement> transfersOut;

  Transfers({
    required this.transfersIn,
    required this.transfersOut,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [transfersIn, transfersOut];
}

class TransfersInElement extends Equatable {
  int playerId;
  String playerName;
  TeamResponse? fromTeam;
  String transferDate;
  TransferType transferType;
  int transferAmount;
  String transferCurrency;
  TeamResponse? toTeam;

  TransfersInElement({
    required this.playerId,
    required this.playerName,
    this.fromTeam,
    required this.transferDate,
    required this.transferType,
    required this.transferAmount,
    required this.transferCurrency,
    this.toTeam,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        toTeam,
        playerId,
        fromTeam,
        transferDate,
        playerName,
        transferType,
        transferAmount,
        transferCurrency
      ];
}
