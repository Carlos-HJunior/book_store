import 'package:book_store/presentation/book_list_view/book_list_item.dart';
import 'package:book_store/presentation/book_list_view/book_list_state.dart';
import 'package:book_store/presentation/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListView extends StatelessWidget {
  const BookListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Store')),
      body: ChangeNotifierProvider(
        create: (consumer) => BookListState(consumer),
        child: Consumer<BookListState>(
          builder: (context, state, _) {
            if (state.loading && state.books.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                ListView.separated(
                  padding: EdgeInsets.all(10),
                  controller: state.controller,
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return BookListItem(
                      book: state.books[index],
                      onTap: () {},
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
          },
        ),
      ),
    );
  }
}
