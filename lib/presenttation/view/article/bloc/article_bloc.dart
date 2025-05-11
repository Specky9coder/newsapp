import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../newsapp.dart';
import 'package:http/http.dart' as http;

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  List<ArticleEntity> _allArticles = [];

  ArticleBloc() : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
    on<SearchArticles>(_onSearchArticles);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onFetchArticles(
      FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        _allArticles = jsonData.map((e) => ArticleEntity.fromJson(e)).toList();

        // Load favorites from shared preferences
        await _loadFavorites();

        emit(ArticleLoaded(_allArticles));
      } else {
        emit(ArticleError('Failed to fetch articles'));
      }
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  void _onSearchArticles(SearchArticles event, Emitter<ArticleState> emit) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(ArticleLoaded(_allArticles));
      return;
    }

    final filtered = _allArticles.where((article) {
      final title = article.title.toLowerCase();
      final body = article.body.toLowerCase();

      return title.contains(query) || body.contains(query);
    }).toList();

    emit(ArticleLoaded(filtered));
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<ArticleState> emit) {
    event.articleEntity.isFavorite = !event.articleEntity.isFavorite;

    // Save updated favorites
    _saveFavorites();

    emit(ArticleLoaded(List.from(_allArticles)));
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds =
        _allArticles.where((a) => a.isFavorite).map((a) => a.id).toList();
    await prefs.setStringList(
        'favorites', favoriteIds.map((e) => e.toString()).toList());
  }

  // Load favorites from SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds =
        prefs.getStringList('favorites')?.map(int.parse).toSet() ?? {};

    for (var article in _allArticles) {
      article.isFavorite = favoriteIds.contains(article.id);
    }
  }
}
