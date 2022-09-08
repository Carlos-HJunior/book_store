import 'package:book_store/presentation/book_list_view/book_list_filter.dart';
import 'package:book_store/presentation/book_list_view/book_list_item.dart';
import 'package:book_store/presentation/book_list_view/book_list_state.dart';
import 'package:book_store/presentation/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListView extends StatelessWidget {
  const BookListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (consumer) => BookListState(consumer),
      child: Consumer<BookListState>(
        builder: (context, state, _) {
          Widget child;
          if (state.loading && state.books.isEmpty) {
            child = const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            child = Stack(
              children: [
                ListView.separated(
                  controller: state.controller,
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return BookListItem(
                      book: state.books[index],
                      onTap: () => state.onBookTap(state.books[index]),
                      onFavoriteTap: state.onFavoriteItemTap,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
                if (state.loading) ...[
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 20,
                    bottom: 24,
                    child: const LoadingWidget(),
                  ),
                ]
              ],
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Book Store'),
              actions: [
                IconButton(
                  icon: Icon(Icons.filter_list_alt),
                  onPressed: () {
                    openFilter(
                      context,
                      state.onlyFavorite,
                      (it) => state.onlyFavorite = it,
                    );
                  },
                ),
              ],
            ),
            body: child,
          );
        },
      ),
    );
  }

  openFilter(BuildContext context, bool switchFavorite, Function function) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BookListFilter(
          switchFavorite: switchFavorite,
          onTimeCallback: function,
        );
      },
    );
  }
}
