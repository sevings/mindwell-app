// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedMessageAdapter extends TypeAdapter<CachedMessage> {
  @override
  final int typeId = 0;

  @override
  CachedMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedMessage(
      id: fields[0] as int?,
      chatId: fields[1] as int?,
      authorName: fields[2] as String?,
      createdAt: fields[3] as double?,
      read: fields[4] as bool,
      content: fields[5] as String?,
      editContent: fields[6] as String?,
      rightsJson: fields[7] as String?,
      chatUsername: fields[8] as String,
      cachedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedMessage obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chatId)
      ..writeByte(2)
      ..write(obj.authorName)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.read)
      ..writeByte(5)
      ..write(obj.content)
      ..writeByte(6)
      ..write(obj.editContent)
      ..writeByte(7)
      ..write(obj.rightsJson)
      ..writeByte(8)
      ..write(obj.chatUsername)
      ..writeByte(9)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
