// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      id: json['_id'] as String,
      author: json['author'] as String,
      authorSlug: json['authorSlug'] as String,
      length: json['length'] as int,
      content: json['content'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateAdded: json['dateAdded'] as String,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'authorSlug': instance.authorSlug,
      'length': instance.length,
      'tags': instance.tags,
      'dateAdded': instance.dateAdded,
      'content': instance.content,
    };
