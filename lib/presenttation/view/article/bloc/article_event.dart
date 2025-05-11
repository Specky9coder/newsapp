import '../../../../newsapp.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class SearchArticles extends ArticleEvent {
  final String query;

  SearchArticles(this.query);
}

class ToggleFavorite extends ArticleEvent {
  final ArticleEntity articleEntity;

  ToggleFavorite(this.articleEntity);
}