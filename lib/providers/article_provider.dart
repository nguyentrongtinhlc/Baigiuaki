import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/api_service.dart';

class ArticleProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Article> _articles = [];
  List<Article> _favorites = [];
  bool isLoading = false;
  String? errorMessage;
  String _searchQuery = '';

  List<Article> get articles => _articles;
  List<Article> get favorites => _favorites;
  List<Article> get filteredArticles {
    if (_searchQuery.isEmpty) {
      return _articles;
    }
    return _articles
        .where((article) => article.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> fetchArticles() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      _articles = await _apiService.fetchArticles();
    } catch (error) {
      errorMessage = 'Không thể tải bài viết. Vui lòng kiểm tra kết nối.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(Article article) {
    if (_favorites.contains(article)) {
      _favorites.remove(article);
    } else {
      _favorites.add(article);
    }
    notifyListeners();
  }

  bool isFavorite(Article article) {
    return _favorites.contains(article);
  }
}
