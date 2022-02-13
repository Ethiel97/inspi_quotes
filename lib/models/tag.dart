import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Tag extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "_id")
  final String id;

  @HiveField(1)
  final String name;

  Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
