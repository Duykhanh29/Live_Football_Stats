// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_team_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteTeamEntityAdapter extends TypeAdapter<FavouriteTeamEntity> {
  @override
  final int typeId = 1;

  @override
  FavouriteTeamEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteTeamEntity(
      uid: fields[0] as String?,
      teams: (fields[1] as List?)?.cast<TeamDataEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteTeamEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.teams);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteTeamEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamDataEntityAdapter extends TypeAdapter<TeamDataEntity> {
  @override
  final int typeId = 3;

  @override
  TeamDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamDataEntity(
      teamID: fields[0] as String?,
      teamName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TeamDataEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.teamID)
      ..writeByte(1)
      ..write(obj.teamName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
