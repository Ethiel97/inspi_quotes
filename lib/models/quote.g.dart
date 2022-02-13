// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteAdapter extends TypeAdapter<Quote> {
  @override
  final int typeId = 0;

  @override
  Quote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quote(
      id: fields[0] as String,
      author: fields[1] as String,
      authorSlug: fields[2] as String,
      length: fields[3] as int,
      content: fields[6] as String,
      tags: (fields[4] as List).cast<String>(),
      dateAdded: fields[5] as String,
      saved: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Quote obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.authorSlug)
      ..writeByte(3)
      ..write(obj.length)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.dateAdded)
      ..writeByte(6)
      ..write(obj.content)
      ..writeByte(7)
      ..write(obj.saved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      id: json['_id'] as String,
      author: json['author'] as String,
      authorSlug: json['authorSlug'] as String,
      length: json['length'] as int,
      content: json['content'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      dateAdded: json['dateAdded'] as String,
      saved: json['saved'] as bool? ?? false,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'authorSlug': instance.authorSlug,
      'length': instance.length,
      'tags': instance.tags,
      'dateAdded': instance.dateAdded,
      'content': instance.content,
      'saved': instance.saved,
    };
