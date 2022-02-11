// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorAdapter extends TypeAdapter<Author> {
  @override
  final int typeId = 1;

  @override
  Author read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Author(
      id: fields[0] as String,
      bio: fields[1] as String,
      description: fields[2] as String,
      link: fields[3] as String,
      name: fields[4] as String,
      slug: fields[5] as String,
      quoteCount: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Author obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bio)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.link)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.slug)
      ..writeByte(6)
      ..write(obj.quoteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['_id'] as String,
      bio: json['bio'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      quoteCount: json['quoteCount'] as String,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      '_id': instance.id,
      'bio': instance.bio,
      'description': instance.description,
      'link': instance.link,
      'name': instance.name,
      'slug': instance.slug,
      'quoteCount': instance.quoteCount,
    };
