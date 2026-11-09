import 'package:flutter/foundation.dart';

class BookmarkItem {
  final String id;
  final String title;
  final String subtitle;

  BookmarkItem({
    required this.id,
    required this.title,
    required this.subtitle,
  });
}

class BookmarkProvider extends ChangeNotifier {
  final Map<String, BookmarkItem> _bookmarks = {};

  Map<String, BookmarkItem> get bookmarks => _bookmarks;

  bool isBookmarked(String id) => _bookmarks.containsKey(id);

  void toggleBookmark(BookmarkItem item) {
    if (_bookmarks.containsKey(item.id)) {
      _bookmarks.remove(item.id);
    } else {
      _bookmarks[item.id] = item;
    }
    notifyListeners();
  }
}