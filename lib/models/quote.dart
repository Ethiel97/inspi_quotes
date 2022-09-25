import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_quotes/repositories/api_repository.dart';
import 'package:smart_quotes/utils/constants.dart';

part 'quote.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Quote extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "_id")
  final String id;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String authorSlug;

  @HiveField(3)
  final int length;

  @HiveField(4)
  final List<String> tags;

  @HiveField(5)
  final String dateAdded;

  @HiveField(6)
  final String content;

  @HiveField(7)
  final bool saved;

  Quote({
    required this.id,
    required this.author,
    required this.authorSlug,
    required this.length,
    required this.content,
    required this.tags,
    required this.dateAdded,
    this.saved = false,
  });

  static Future<Quote> create(Map<String, dynamic> json) async {
    Quote quote = Quote.fromJson(json);

    final APIRepository apiRepository = APIRepository(apiUrl: apiUrl);

    String translatedContent = await apiRepository.translateToAppLocale(
        text: quote.content,
        target: WidgetsBinding.instance.window.locale.languageCode);

    return Quote(
      author: quote.author,
      authorSlug: quote.authorSlug,
      id: quote.id,
      length: quote.length,
      content: translatedContent,
      dateAdded: quote.dateAdded,
      tags: quote.tags,
      saved: quote.saved,
    );
  }

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Quote copyWith({
    String? id,
    String? author,
    String? authorSlug,
    int? length,
    String? content,
    List<String>? tags,
    String? dateAdded,
    bool? saved = false,
  }) =>
      Quote(
        author: author ?? this.author,
        authorSlug: authorSlug ?? this.authorSlug,
        id: id ?? this.id,
        length: length ?? this.length,
        content: content ?? this.content,
        dateAdded: dateAdded ?? this.dateAdded,
        tags: tags ?? this.tags,
        saved: saved ?? this.saved,
      );

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
