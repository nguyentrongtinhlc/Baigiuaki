import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/article_provider.dart';
import '../screens/favorite_screen.dart';
import '../widgets/article_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Future.microtask(
      () => Provider.of<ArticleProvider>(context, listen: false).fetchArticles(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin tức'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.fetchArticles,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm theo tiêu đề...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: provider.setSearchQuery,
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const SizedBox(
                height: 400,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (provider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: provider.fetchArticles,
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              )
            else if (provider.filteredArticles.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Không tìm thấy bài viết phù hợp.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              )
            else
              ...provider.filteredArticles
                  .map((article) => ArticleItem(article: article))
                  .toList(),
          ],
        ),
      ),
    );
  }
}
