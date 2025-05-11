import 'package:flutter/material.dart';

import '../../../newsapp.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Article Details'),
      ),
      body:
          //
          SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  article.body,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
