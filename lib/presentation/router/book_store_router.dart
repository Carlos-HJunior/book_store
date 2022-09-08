import 'package:book_store/presentation/book_detail_view/book_detail_view.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/book.dart';
import '../book_list_view/book_list_view.dart';

class BookStoreRouter {
  static const bookListRoute = '/';
  static const bookDetailRoute = '/detail';


  static Map<String, WidgetBuilder> routes() {
    return {
      bookListRoute: (_) => const BookListView(),
      bookDetailRoute: (context) => BookDetailView(ModalRoute.of(context)!.settings.arguments as Book),
    };
  }
}
