import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/article_provider.dart';
import '../widgets/article_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin yêu thích'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Bạn chưa có bài viết yêu thích nào.\nHãy đánh dấu yêu thích từ màn hình chính.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return ArticleItem(article: favorites[index]);
              },
            ),
    );
  }
}
