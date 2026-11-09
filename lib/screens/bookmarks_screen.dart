import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bookmark_provider.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final items = bookmarkProvider.bookmarks.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Bookmarks'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: items.isEmpty
          ? const Center(child: Text("No bookmarks saved yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.bookmark, color: Colors.indigo),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item.subtitle),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => bookmarkProvider.toggleBookmark(item),
                    ),
                  ),
                );
              },
            ),
    );
  }
}