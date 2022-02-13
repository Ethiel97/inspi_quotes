import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Author extends HiveObject{
  @HiveField(0)
  @JsonKey(name: "_id")
  final String id;

  @HiveField(1)
  final String bio;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String link;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final String slug;

  @HiveField(6)
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
