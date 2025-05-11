import 'package:json_annotation/json_annotation.dart';



part 'article_entity.g.dart';

@JsonSerializable()
class ArticleEntity {
  final int id;
  final String title;
  final String body;
  bool isFavorite;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.body,
    this.isFavorite = false,
  });

  factory ArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$ArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleEntityToJson(this);
}
