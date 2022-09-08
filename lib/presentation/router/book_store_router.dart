import 'package:flutter/widgets.dart';

import '../book_list_view/book_list_view.dart';

class BookStoreRouter {
  static const bookListRoute = '/';
  static const bookDetailRoute = '/detail';


  static Map<String, WidgetBuilder> routes() {
    return {
      bookListRoute: (_) => const BookListView(),
      // bookDetailRoute: (_) => const BookList(),
    };
  }
}
