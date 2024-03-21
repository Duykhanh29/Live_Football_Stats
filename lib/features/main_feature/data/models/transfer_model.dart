// To parse this JSON data, do
//
//     final transferModel = transferModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart'
    as transferEntity;

TransferModel transferModelFromJson(String str) =>
    TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) => json.encode(data.toJson());

class TransferModel {
  int id;
  String name;
  Transfers transfers;

  TransferModel({
    required this.id,
    required this.name,
    required this.transfers,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        id: json["id"],
        name: json["name"],
        transfers: Transfers.fromJson(json["transfers"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "transfers": transfers.toJson(),
      };
  transferEntity.Transfer toEntity() {
    return transferEntity.Transfer(
        id: id, name: name, transfers: transfers.toEntity());
  }
}

class Transfers {
  List<TransfersInElement> transfersIn;
  List<TransfersInElement> transfersOut;

  Transfers({
    required this.transfersIn,
    required this.transfersOut,
  });

  factory Transfers.fromJson(Map<String, dynamic> json) => Transfers(
        transfersIn: List<TransfersInElement>.from(
            json["transfers_in"].map((x) => TransfersInElement.fromJson(x))),
        transfersOut: List<TransfersInElement>.from(
            json["transfers_out"].map((x) => TransfersInElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transfers_in": List<dynamic>.from(transfersIn.map((x) => x.toJson())),
        "transfers_out":
            List<dynamic>.from(transfersOut.map((x) => x.toJson())),
      };
  transferEntity.Transfers toEntity() {
    return transferEntity.Transfers(
        transfersIn: transfersIn.map((e) => e.toEntity()).toList(),
        transfersOut: transfersOut.map((e) => e.toEntity()).toList());
  }
}

class TransfersInElement {
  int playerId;
  String playerName;
  TeamModelResponse? fromTeam;
  String transferDate;
  TransferType transferType;
  int transferAmount;
  String transferCurrency;
  TeamModelResponse? toTeam;

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

  factory TransfersInElement.fromJson(Map<String, dynamic> json) =>
      TransfersInElement(
        playerId: json["player_id"],
        playerName: json["player_name"],
        fromTeam: json["from_team"] == null
            ? null
            : TeamModelResponse.fromJson(json["from_team"]),
        transferDate: json["transfer_date"],
        transferType: transferTypeValues.map[json["transfer_type"]]!,
        transferAmount: json["transfer_amount"],
        transferCurrency: json["transfer_currency"],
        toTeam: json["to_team"] == null
            ? null
            : TeamModelResponse.fromJson(json["to_team"]),
      );

  Map<String, dynamic> toJson() => {
        "player_id": playerId,
        "player_name": playerName,
        "from_team": fromTeam?.toJson(),
        "transfer_date": transferDate,
        "transfer_type": transferTypeValues.reverse[transferType],
        "transfer_amount": transferAmount,
        "transfer_currency": transferCurrency,
        "to_team": toTeam?.toJson(),
      };
  transferEntity.TransfersInElement toEntity() {
    return transferEntity.TransfersInElement(
        playerId: playerId,
        playerName: playerName,
        transferDate: transferDate,
        transferType: transferType,
        transferAmount: transferAmount,
        transferCurrency: transferCurrency,
        fromTeam: fromTeam != null ? fromTeam!.toEntity() : null,
        toTeam: toTeam != null ? toTeam!.toEntity() : null);
  }
}
