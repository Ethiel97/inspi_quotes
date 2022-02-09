import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  @JsonKey(name: "_id")
  final String id;

  final String author;

  final String authorSlug;

  final int length;

  final List<String> tags;

  final String dateAdded;

   String content;

  Quote({
    required this.id,
    required this.author,
    required this.authorSlug,
    required this.length,
    required this.content,
    required this.tags,
    required this.dateAdded,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Quote copyWith({
    String? id,
    String? author,
    String? authorSlug,
    int? length,
    String? content,
    List<String>? tags,
    String? dateAdded,
  }) {
    return Quote(
      author: author ?? this.author,
      authorSlug: authorSlug ?? this.authorSlug,
      id: id ?? this.id,
      length: length ?? this.length,
      content: content ?? this.content,
      dateAdded: dateAdded ?? this.dateAdded,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
