// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_league_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteLeagueEntityAdapter extends TypeAdapter<FavouriteLeagueEntity> {
  @override
  final int typeId = 0;

  @override
  FavouriteLeagueEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteLeagueEntity(
      uid: fields[0] as String?,
      leagues: (fields[1] as List?)?.cast<LeagueDataEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteLeagueEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.leagues);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteLeagueEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LeagueDataEntityAdapter extends TypeAdapter<LeagueDataEntity> {
  @override
  final int typeId = 2;

  @override
  LeagueDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LeagueDataEntity(
      leagueName: fields[1] as String?,
      leagueID: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LeagueDataEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.leagueID)
      ..writeByte(1)
      ..write(obj.leagueName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeagueDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
