import 'package:flutter/widgets.dart';

import '../book_list_view/book_list_view.dart';

class BookStoreRouter {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/': (_) => const BookListView(),
      // '/detail': (_) => const BookList(),
    };
  }
}
