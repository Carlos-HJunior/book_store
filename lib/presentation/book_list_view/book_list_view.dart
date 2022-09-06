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
                GridView.builder(
                  controller: state.controller,
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return BookListItem(
                      onTap: () {},
                      book: state.books[index],
                    );
                  },
                ),
                if (state.loading)...[
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
