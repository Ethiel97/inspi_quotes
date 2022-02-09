import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  @JsonKey(name: "_id")
  final String id;

  final String bio;

  final String description;

  final String link;

  final String name;

  final String slug;

  final String quoteCount;

  Author({
    required this.id,
    required this.bio,
    required this.description,
    required this.link,
    required this.name,
    required this.slug,
    required this.quoteCount,
  });

  Author copyWith({
    String? id,
    String? bio,
    String? description,
    String? name,
    String? link,
    String? slug,
    String? quoteCount,
  }) {
    return Author(
      id: id ?? this.id,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      link: link ?? this.link,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      quoteCount: quoteCount ?? this.quoteCount,
    );
  }

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
