// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackModelAdapter extends TypeAdapter<TrackModel> {
  @override
  final int typeId = 1;

  @override
  TrackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackModel(
      message: fields[0] as Message?,
    );
  }

  @override
  void write(BinaryWriter writer, TrackModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 2;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      body: fields[1] as Body?,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrackAdapter extends TypeAdapter<Track> {
  @override
  final int typeId = 3;

  @override
  Track read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Track(
      trackDetail: fields[4] as TrackDetail,
    );
  }

  @override
  void write(BinaryWriter writer, Track obj) {
    writer
      ..writeByte(1)
      ..writeByte(4)
      ..write(obj.trackDetail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrackDetailAdapter extends TypeAdapter<TrackDetail> {
  @override
  final int typeId = 4;

  @override
  TrackDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackDetail(
      trackId: fields[6] as String,
      artistId: fields[8] as String,
      trackName: fields[7] as String,
      artistName: fields[9] as String,
      hasLyrics: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TrackDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(6)
      ..write(obj.trackId)
      ..writeByte(7)
      ..write(obj.trackName)
      ..writeByte(8)
      ..write(obj.artistId)
      ..writeByte(9)
      ..write(obj.artistName)
      ..writeByte(10)
      ..write(obj.hasLyrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
