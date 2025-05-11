import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'newsapp.dart';
import 'presenttation/view/home/home_screen.dart';

// Replace with your actual provider file

// void main() {
//   runApp(
//     BlocProvider(
//       create: (_) => ArticleBloc()..add(FetchArticles()),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'News App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: HomeScreen(), // <- this contains the Scaffold
//     );
//   }
// }
//
// class Article {
//   final int id;
//   final String title;
//   final String body;
//   bool isFavorite;
//
//   Article({
//     required this.id,
//     required this.title,
//     required this.body,
//     this.isFavorite = false,
//   });
//
//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//       isFavorite: json['isFavorite'] ?? false,
//     );
//   }
// }
//
// class ApiService {
//   static const _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
//
//   static Future<List<Article>> fetchArticles() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));
//       if (response.statusCode == 200) {
//         List data = json.decode(response.body);
//         return data.map((json) => Article.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load articles');
//       }
//     } catch (e) {
//       throw Exception('API Error: $e');
//     }
//   }
// }
//
//
//
//
//
// class ArticleDetailScreen extends StatelessWidget {
//   final Article article;
//
//   const ArticleDetailScreen({required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Article Detail")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(article.title, style: Theme.of(context).textTheme.titleLarge),
//             SizedBox(height: 12),
//             Text(article.body),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// abstract class ArticleState {}
//
// class ArticleInitial extends ArticleState {}
//
// class ArticleLoading extends ArticleState {}
//
// class ArticleLoaded extends ArticleState {
//   final List<Article> articles;
//
//   ArticleLoaded(this.articles);
// }
//
// class ArticleError extends ArticleState {
//   final String message;
//
//   ArticleError(this.message);
// }
//
// abstract class ArticleEvent {}
//
// class FetchArticles extends ArticleEvent {}
//
// class SearchArticles extends ArticleEvent {
//   final String query;
//
//   SearchArticles(this.query);
// }
//
// class ToggleFavorite extends ArticleEvent {
//   final Article article;
//
//   ToggleFavorite(this.article);
// }
//
//
//
// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Favorites')),
//       body: BlocBuilder<ArticleBloc, ArticleState>(
//         builder: (context, state) {
//           if (state is ArticleLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ArticleLoaded) {
//             final favoriteArticles =
//                 state.articles.where((article) => article.isFavorite).toList();
//             return ListView.builder(
//               itemCount: favoriteArticles.length,
//               itemBuilder: (context, index) {
//                 final article = favoriteArticles[index];
//                 return ListTile(
//                   title: Text(article.title),
//                   subtitle: Text(article.body),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) =>
//                               ArticleDetailScreen(article: article)),
//                     );
//                   },
//                 );
//               },
//             );
//           } else if (state is ArticleError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
//
//
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Articles'),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue, Colors.purple],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'All Articles'),
//               Tab(text: 'Favorites'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     onChanged: (query) {
//                       context.read<ArticleBloc>().add(SearchArticles(query));
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search...',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: BlocBuilder<ArticleBloc, ArticleState>(
//                     builder: (context, state) {
//                       if (state is ArticleLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (state is ArticleLoaded) {
//                         return RefreshIndicator(
//                           onRefresh: () async {
//                             context.read<ArticleBloc>().add(FetchArticles());
//                           },
//                           child: ListView.builder(
//                             itemCount: state.articles.length,
//                             itemBuilder: (context, index) {
//                               final article = state.articles[index];
//                               return Card(
//                                 elevation: 4,
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 12),
//                                 child: ListTile(
//                                   contentPadding: EdgeInsets.all(16),
//                                   title: Text(
//                                     article.title,
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   subtitle: Text(
//                                     article.body,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   trailing: IconButton(
//                                     icon: Icon(
//                                       article.isFavorite
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                       color: article.isFavorite
//                                           ? Colors.red
//                                           : null,
//                                     ),
//                                     onPressed: () {
//                                       context
//                                           .read<ArticleBloc>()
//                                           .add(ToggleFavorite(article));
//                                     },
//                                   ),
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => ArticleDetailScreen(
//                                               article: article)),
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       } else if (state is ArticleError) {
//                         return Center(child: Text(state.message));
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             FavoritesScreen(), // Favorites Tab
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
//   List<Article> _allArticles = [];
//
//   ArticleBloc() : super(ArticleInitial()) {
//     on<FetchArticles>(_onFetchArticles);
//     on<SearchArticles>(_onSearchArticles);
//     on<ToggleFavorite>(_onToggleFavorite);
//   }
//
//   Future<void> _onFetchArticles(
//       FetchArticles event, Emitter<ArticleState> emit) async {
//     emit(ArticleLoading());
//     try {
//       final response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//       if (response.statusCode == 200) {
//         final List jsonData = json.decode(response.body);
//         _allArticles = jsonData.map((e) => Article.fromJson(e)).toList();
//
//         // Load favorites from shared preferences
//         await _loadFavorites();
//
//         emit(ArticleLoaded(_allArticles));
//       } else {
//         emit(ArticleError('Failed to fetch articles'));
//       }
//     } catch (e) {
//       emit(ArticleError(e.toString()));
//     }
//   }
//
//   void _onSearchArticles(SearchArticles event, Emitter<ArticleState> emit) {
//     final query = event.query.trim().toLowerCase();
//
//     if (query.isEmpty) {
//       emit(ArticleLoaded(_allArticles));
//       return;
//     }
//
//     final filtered = _allArticles.where((article) {
//       final title = article.title.toLowerCase();
//       final body = article.body.toLowerCase();
//
//       return title.contains(query) || body.contains(query);
//     }).toList();
//
//     emit(ArticleLoaded(filtered));
//   }
//
//   void _onToggleFavorite(ToggleFavorite event, Emitter<ArticleState> emit) {
//     event.article.isFavorite = !event.article.isFavorite;
//
//     // Save updated favorites
//     _saveFavorites();
//
//     emit(ArticleLoaded(List.from(_allArticles)));
//   }
//
//   // Save favorites to SharedPreferences
//   Future<void> _saveFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final favoriteIds =
//         _allArticles.where((a) => a.isFavorite).map((a) => a.id).toList();
//     await prefs.setStringList(
//         'favorites', favoriteIds.map((e) => e.toString()).toList());
//   }
//
//   // Load favorites from SharedPreferences
//   Future<void> _loadFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final favoriteIds =
//         prefs.getStringList('favorites')?.map(int.parse).toSet() ?? {};
//
//     for (var article in _allArticles) {
//       article.isFavorite = favoriteIds.contains(article.id);
//     }
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Articles'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'All Articles'),
//               Tab(text: 'Favorites'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             BlocBuilder<ArticleBloc, ArticleState>(
//               builder: (context, state) {
//                 if (state is ArticleLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is ArticleLoaded) {
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       context.read<ArticleBloc>().add(FetchArticles());
//                     },
//                     child: ListView.builder(
//                       itemCount: state.articles.length,
//                       itemBuilder: (context, index) {
//                         final article = state.articles[index];
//                         return ListTile(
//                           title: Text(article.title),
//                           subtitle: Text(article.body, maxLines: 2, overflow: TextOverflow.ellipsis),
//                           trailing: IconButton(
//                             icon: Icon(
//                               article.isFavorite ? Icons.favorite : Icons.favorite_border,
//                               color: article.isFavorite ? Colors.red : null,
//                             ),
//                             onPressed: () {
//                               context.read<ArticleBloc>().add(ToggleFavorite(article));
//                             },
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 } else if (state is ArticleError) {
//                   return Center(child: Text(state.message));
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//             FavoritesScreen(), // Favorites Tab
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
//   List<Article> _allArticles = [];
//
//   ArticleBloc() : super(ArticleInitial()) {
//     on<FetchArticles>(_onFetchArticles);
//     on<SearchArticles>(_onSearchArticles);
//     on<ToggleFavorite>(_onToggleFavorite);
//   }
//
//   Future<void> _onFetchArticles(
//       FetchArticles event, Emitter<ArticleState> emit) async {
//     emit(ArticleLoading());
//     try {
//       final response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//       if (response.statusCode == 200) {
//         final List jsonData = json.decode(response.body);
//         _allArticles = jsonData.map((e) => Article.fromJson(e)).toList();
//         emit(ArticleLoaded(_allArticles));
//       } else {
//         emit(ArticleError('Failed to fetch articles'));
//       }
//     } catch (e) {
//       emit(ArticleError(e.toString()));
//     }
//   }
//
//   void _onSearchArticles(SearchArticles event, Emitter<ArticleState> emit) {
//     final query = event.query.trim().toLowerCase();
//
//     if (query.isEmpty) {
//       emit(ArticleLoaded(_allArticles));
//       return;
//     }
//
//     final filtered = _allArticles.where((article) {
//       final title = article.title.toLowerCase();
//       final body = article.body.toLowerCase();
//
//       return title.contains(query) || body.contains(query);
//     }).toList();
//
//     emit(ArticleLoaded(filtered));
//   }
//
//
//   void _onToggleFavorite(ToggleFavorite event, Emitter<ArticleState> emit) {
//     event.article.isFavorite = !event.article.isFavorite;
//     emit(ArticleLoaded(List.from(_allArticles)));
//   }
//
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Articles')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (query) {
//                 context.read<ArticleBloc>().add(SearchArticles(query));
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: BlocBuilder<ArticleBloc, ArticleState>(
//               builder: (context, state) {
//                 if (state is ArticleLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is ArticleLoaded) {
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       context.read<ArticleBloc>().add(FetchArticles());
//                     },
//                     child: ListView.builder(
//                       itemCount: state.articles.length,
//                       itemBuilder: (context, index) {
//                         final article = state.articles[index];
//                         return ListTile(
//                           title: Text(article.title),
//                           subtitle: Text(article.body, maxLines: 2, overflow: TextOverflow.ellipsis),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 } else if (state is ArticleError) {
//                   return Center(child: Text(state.message));
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }

// class ArticleProvider extends ChangeNotifier {
//   List<Article> _articles = [];
//   bool _isLoading = true;
//
//   ArticleProvider() {
//     fetchArticles();
//   }
//
//   List<Article> get articles => _articles;
//
//   bool get isLoading => _isLoading;
//
//   Future<void> fetchArticles() async {
//     try {
//       final response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//       if (response.statusCode == 200) {
//         List jsonData = json.decode(response.body);
//         _articles = jsonData.map((e) => Article.fromJson(e)).toList();
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ArticleBloc()..add(FetchArticles()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// class Article {
//   final int id;
//   final String title;
//   final String body;
//   bool isFavorite;
//
//   Article({
//     required this.id,
//     required this.title,
//     required this.body,
//     this.isFavorite = false,
//   });
//
//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//       isFavorite: json['isFavorite'] ?? false,
//     );
//   }
// }
//
// class ApiService {
//   static const _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
//
//   static Future<List<Article>> fetchArticles() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));
//       if (response.statusCode == 200) {
//         List data = json.decode(response.body);
//         return data.map((json) => Article.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load articles');
//       }
//     } catch (e) {
//       throw Exception('API Error: $e');
//     }
//   }
// }

// class ArticleDetailScreen extends StatelessWidget {
//   final Article article;
//
//   const ArticleDetailScreen({required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Article Detail")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(article.title, style: Theme.of(context).textTheme.titleLarge),
//             SizedBox(height: 12),
//             Text(article.body, style: Theme.of(context).textTheme.bodyLarge),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ArticleDetailScreen extends StatelessWidget {
//   final Article article;
//
//   const ArticleDetailScreen({Key? key, required this.article})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Article Details'),
//       ),
//       body:
//           //
//           SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//             side: BorderSide(
//               color: Colors.grey.withOpacity(0.2),
//               width: 1,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // 👈 ensures content-based height
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   article.title,
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 const SizedBox(height: 12),
//                 const Divider(),
//                 const SizedBox(height: 12),
//                 Text(
//                   article.body,
//                   style: Theme.of(context).textTheme.bodyLarge,
//                   textAlign: TextAlign.justify,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// abstract class ArticleState {}
//
// class ArticleInitial extends ArticleState {}
//
// class ArticleLoading extends ArticleState {}
//
// class ArticleLoaded extends ArticleState {
//   final List<Article> articles;
//
//   ArticleLoaded(this.articles);
// }
//
// class ArticleError extends ArticleState {
//   final String message;
//
//   ArticleError(this.message);
// }
//
// abstract class ArticleEvent {}
//
// class FetchArticles extends ArticleEvent {}
//
// class SearchArticles extends ArticleEvent {
//   final String query;
//
//   SearchArticles(this.query);
// }
//
// class ToggleFavorite extends ArticleEvent {
//   final Article article;
//
//   ToggleFavorite(this.article);
// }

// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Favorites')),
//       body: BlocBuilder<ArticleBloc, ArticleState>(
//         builder: (context, state) {
//           if (state is ArticleLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ArticleLoaded) {
//             final favoriteArticles =
//                 state.articles.where((article) => article.isFavorite).toList();
//             return ListView.builder(
//               itemCount: favoriteArticles.length,
//               itemBuilder: (context, index) {
//                 final article = favoriteArticles[index];
//                 // return Card(
//                 //   shape: RoundedRectangleBorder(
//                 //     borderRadius: BorderRadius.circular(40),
//                 //     // if you need this
//                 //     side: BorderSide(
//                 //       color: Colors.grey.withOpacity(0.2),
//                 //       width: 1,
//                 //     ),
//                 //   ),
//                 //   margin:
//                 //       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 //   child: ListTile(
//                 //     contentPadding: EdgeInsets.all(16),
//                 //     title: Text(
//                 //       article.title,
//                 //       style: Theme.of(context).textTheme.titleLarge,
//                 //       overflow: TextOverflow.ellipsis,
//                 //       maxLines: 2,
//                 //     ),
//                 //     subtitle: Text(
//                 //       article.body,
//                 //       style: Theme.of(context).textTheme.bodyMedium,
//                 //       // overflow: TextOverflow.ellipsis,
//                 //       // softWrap: true,
//                 //       // maxLines: 2,
//                 //         softWrap: true, // Allow the text to wrap
//                 //         overflow: TextOverflow.ellipsis,
//                 //         maxLines: 3
//                 //     ),
//                 //     onTap: () {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //             builder: (_) =>
//                 //                 ArticleDetailScreen(article: article)),
//                 //       );
//                 //     },
//                 //   ),
//                 // );
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     side: BorderSide(
//                       color: Colors.grey.withOpacity(0.2),
//                       width: 1,
//                     ),
//                   ),
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Title
//                         Text(
//                           article.title,
//                           style: Theme.of(context).textTheme.titleLarge,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                         ),
//                         SizedBox(height: 8),
//                         // Body/Description
//                         Text(
//                           article.body,
//                           style: Theme.of(context).textTheme.bodyMedium,
//                           softWrap: true,
//                           // Allow text to wrap to the next line
//                           overflow: TextOverflow.ellipsis,
//                           // Add ellipsis if text overflows
//                           maxLines:
//                               3, // You can adjust this based on how much text you want visible
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is ArticleError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Center(child: Text('No favorites added.'));
//           }
//         },
//       ),
//     );
//   }
// }

// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Favorites')),
//       body: BlocBuilder<ArticleBloc, ArticleState>(
//         builder: (context, state) {
//           if (state is ArticleLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is ArticleLoaded) {
//             final favoriteArticles =
//                 state.articles.where((article) => article.isFavorite).toList();
//
//             if (favoriteArticles.isEmpty) {
//               return Center(child: Text('No favorites added.'));
//             }
//
//             return ListView.builder(
//               itemCount: favoriteArticles.length,
//               itemBuilder: (context, index) {
//                 final article = favoriteArticles[index];
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     side: BorderSide(
//                       color: Colors.grey.withOpacity(0.2),
//                       width: 1,
//                     ),
//                   ),
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(16),
//                     title: Text(
//                       article.title,
//                       style: Theme.of(context).textTheme.titleLarge,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                     subtitle: Text(
//                       article.body,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(
//                         article.isFavorite
//                             ? Icons.favorite
//                             : Icons.favorite_border,
//                         color: article.isFavorite ? Colors.red : null,
//                       ),
//                       onPressed: () {
//                         context
//                             .read<ArticleBloc>()
//                             .add(ToggleFavorite(article));
//                       },
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ArticleDetailScreen(article: article),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           } else if (state is ArticleError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Center(child: Text('No favorites added.'));
//           }
//         },
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text('Articles'),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//                 // gradient: LinearGradient(
//                 //   colors: [Colors.blue, Colors.purple],
//                 //   begin: Alignment.topLeft,
//                 //   end: Alignment.bottomRight,
//                 // ),
//                 color: Colors.white),
//           ),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'All Articles'),
//               Tab(text: 'Favorites'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     onChanged: (query) {
//                       context.read<ArticleBloc>().add(SearchArticles(query));
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search...',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: BlocBuilder<ArticleBloc, ArticleState>(
//                     builder: (context, state) {
//                       if (state is ArticleLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (state is ArticleLoaded) {
//                         return RefreshIndicator(
//                           onRefresh: () async {
//                             context.read<ArticleBloc>().add(FetchArticles());
//                           },
//                           child: ListView.builder(
//                             itemCount: state.articles.length,
//                             itemBuilder: (context, index) {
//                               final article = state.articles[index];
//                               return Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(40),
//                                   // if you need this
//                                   side: BorderSide(
//                                     color: Colors.grey.withOpacity(0.2),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 16),
//                                 child: ListTile(
//                                   contentPadding: EdgeInsets.all(16),
//                                   title: Text(
//                                     article.title,
//                                     style:
//                                         Theme.of(context).textTheme.titleLarge,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                   ),
//                                   subtitle: Text(
//                                     article.body,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style:
//                                         Theme.of(context).textTheme.bodyMedium,
//                                   ),
//                                   trailing: IconButton(
//                                     icon: Icon(
//                                       article.isFavorite
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                       color: article.isFavorite
//                                           ? Colors.red
//                                           : null,
//                                     ),
//                                     onPressed: () {
//                                       context
//                                           .read<ArticleBloc>()
//                                           .add(ToggleFavorite(article));
//                                     },
//                                   ),
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => ArticleDetailScreen(
//                                               article: article)),
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       } else if (state is ArticleError) {
//                         return Center(child: Text(state.message));
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             FavoritesScreen(), // Favorites Tab
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             context.read<ArticleBloc>().add(FetchArticles());
//           },
//           child: Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }
//
// class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
//   List<Article> _allArticles = [];
//
//   ArticleBloc() : super(ArticleInitial()) {
//     on<FetchArticles>(_onFetchArticles);
//     on<SearchArticles>(_onSearchArticles);
//     on<ToggleFavorite>(_onToggleFavorite);
//   }
//
//   Future<void> _onFetchArticles(
//       FetchArticles event, Emitter<ArticleState> emit) async {
//     emit(ArticleLoading());
//     try {
//       final response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//       if (response.statusCode == 200) {
//         final List jsonData = json.decode(response.body);
//         _allArticles = jsonData.map((e) => Article.fromJson(e)).toList();
//
//         // Load favorites from shared preferences
//         await _loadFavorites();
//
//         emit(ArticleLoaded(_allArticles));
//       } else {
//         emit(ArticleError('Failed to fetch articles'));
//       }
//     } catch (e) {
//       emit(ArticleError(e.toString()));
//     }
//   }
//
//   void _onSearchArticles(SearchArticles event, Emitter<ArticleState> emit) {
//     final query = event.query.trim().toLowerCase();
//
//     if (query.isEmpty) {
//       emit(ArticleLoaded(_allArticles));
//       return;
//     }
//
//     final filtered = _allArticles.where((article) {
//       final title = article.title.toLowerCase();
//       final body = article.body.toLowerCase();
//
//       return title.contains(query) || body.contains(query);
//     }).toList();
//
//     emit(ArticleLoaded(filtered));
//   }
//
//   void _onToggleFavorite(ToggleFavorite event, Emitter<ArticleState> emit) {
//     event.article.isFavorite = !event.article.isFavorite;
//
//     // Save updated favorites
//     _saveFavorites();
//
//     emit(ArticleLoaded(List.from(_allArticles)));
//   }
//
//   // Save favorites to SharedPreferences
//   Future<void> _saveFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final favoriteIds =
//         _allArticles.where((a) => a.isFavorite).map((a) => a.id).toList();
//     await prefs.setStringList(
//         'favorites', favoriteIds.map((e) => e.toString()).toList());
//   }
//
//   // Load favorites from SharedPreferences
//   Future<void> _loadFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final favoriteIds =
//         prefs.getStringList('favorites')?.map(int.parse).toSet() ?? {};
//
//     for (var article in _allArticles) {
//       article.isFavorite = favoriteIds.contains(article.id);
//     }
//   }
// }
