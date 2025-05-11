// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleEntity _$ArticleEntityFromJson(Map<String, dynamic> json) =>
    ArticleEntity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$ArticleEntityToJson(ArticleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'isFavorite': instance.isFavorite,
    };
