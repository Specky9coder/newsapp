import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../newsapp.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(backgroundColor: Colors.white, title: const Text('Favorites')),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            final favoriteArticles =
                state.articles.where((article) => article.isFavorite).toList();

            if (favoriteArticles.isEmpty) {
              return const Center(child: Text('No favorites added.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ArticleBloc>().add(FetchArticles());
              },
              child: ListView.builder(
                itemCount: favoriteArticles.length,
                itemBuilder: (context, index) {
                  final article = favoriteArticles[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        article.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      subtitle: Text(
                        article.body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          article.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: article.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          context
                              .read<ArticleBloc>()
                              .add(ToggleFavorite(article));
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ArticleDetailScreen(article: article),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is ArticleError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No favorites added.'));
          }
        },
      ),
    );
  }
}
