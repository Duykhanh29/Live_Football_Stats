// team
enum EventTeam { HOME, AWAY }

final eventTeam = EnumValues({
  'home': EventTeam.HOME,
  'away': EventTeam.AWAY,
});

// position
enum Position { ATTACKER, DEFENDER, GOALKEEPER, M, MIDFIELDER }

final positionValues = EnumValues({
  "Attacker": Position.ATTACKER,
  "Defender": Position.DEFENDER,
  "Goalkeeper": Position.GOALKEEPER,
  "M": Position.M,
  "Midfielder": Position.MIDFIELDER
});

// matchStatus
enum MatchStatus { DELAYED, FINISHED, LIVE, PRE_MATCH }

final matchStatusValues = EnumValues({
  "delayed": MatchStatus.DELAYED,
  "finished": MatchStatus.FINISHED,
  "live": MatchStatus.LIVE,
  "pre-match": MatchStatus.PRE_MATCH
});

// eventType
enum EventType {
  GOAL,
  OWN_GOAL,
  PENALTY_GOAL,
  RED_CARD,
  SUBSTITUTION,
  YELLOW_CARD,
  YELLOW_RED_CARD
}

final eventTypeValues = EnumValues({
  "goal": EventType.GOAL,
  "own_goal": EventType.OWN_GOAL,
  "penalty_goal": EventType.PENALTY_GOAL,
  "red_card": EventType.RED_CARD,
  "substitution": EventType.SUBSTITUTION,
  "yellow_card": EventType.YELLOW_CARD,
  "yellow_red_card": EventType.YELLOW_RED_CARD
});

// winner
enum Winner { AWAY, DRAW, HOME, TBD }

final winnerValues = EnumValues({
  "away": Winner.AWAY,
  "draw": Winner.DRAW,
  "home": Winner.HOME,
  "tbd": Winner.TBD
});

// lineupType
enum LineupType { LIVE, NONE, PROJECTED }

final lineupTypeValues = EnumValues({
  "live": LineupType.LIVE,
  "None": LineupType.NONE,
  "projected": LineupType.PROJECTED
});

// transfer
enum TransferType { FREE, LOAN, N_A, TRANSFER_FEE }

final transferTypeValues = EnumValues({
  "free": TransferType.FREE,
  "loan": TransferType.LOAN,
  "n/a": TransferType.N_A,
  "transfer-fee": TransferType.TRANSFER_FEE
});

enum TypeOfTransfer { TransferIn, TransferOut }

// auth option
enum AuthOption { Google, PhoneNumber, Facebook }

final AuthOptionValues = EnumValues({
  "Google": AuthOption.Google,
  "PhoneNumber": AuthOption.PhoneNumber,
  "Facebook": AuthOption.Facebook,
});

enum LogContentType { Match, Team, League }

final LogContentTypeValues = EnumValues({
  "Google": AuthOption.Google,
  "PhoneNumber": AuthOption.PhoneNumber,
  "Facebook": AuthOption.Facebook,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
