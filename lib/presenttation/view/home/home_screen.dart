import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../newsapp.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('News'),
          flexibleSpace: Container(
            color: Colors.white,
            // decoration: const BoxDecoration(color: Colors.white),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Articles'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) {
                      context.read<ArticleBloc>().add(SearchArticles(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ArticleLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ArticleLoaded) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            context.read<ArticleBloc>().add(FetchArticles());
                          },
                          child: ListView.builder(
                            itemCount: state.articles.length,
                            itemBuilder: (context, index) {
                              final article = state.articles[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    article.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  subtitle: Text(
                                    article.body,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      article.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: article.isFavorite
                                          ? Colors.red
                                          : null,
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
                                          builder: (_) => ArticleDetailScreen(
                                              article: article)),
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
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
            const FavoritesScreen(), // Favorites Tab
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ArticleBloc>().add(FetchArticles());
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
