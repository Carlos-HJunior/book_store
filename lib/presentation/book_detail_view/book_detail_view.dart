import 'package:book_store/domain/entities/book.dart';
import 'package:book_store/presentation/book_detail_view/book_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/text_widget.dart';

class BookDetailView extends StatelessWidget {
  BookDetailView(this.book);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookDetailState>(
      create: (context) => BookDetailState(context, book),
      child: Consumer<BookDetailState>(
        builder: (context, state, scaffold) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, state.needReload);
              return false;
            },
            child: scaffold!,
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detail'),
          ),
          body: _BookInfo(),
        ),
      ),
    );
  }
}

class _BookInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailState>(
      builder: (context, state, _) {
        return ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: state.onFavoriteItemTap,
                  icon: Icon(
                    state.book.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.amber[700],
                  ),
                ),
                Expanded(child: BaseTitle(state.book.title!)),
              ],
            ),
            Center(
              child: SizedBox(
                width: 180,
                child: Image.network(state.book.thumbnail!, fit: BoxFit.cover),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: LabelText(state.book.visualPrice),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )),
                  ),
                  onPressed: state.book.buyLink != null ? state.onBuyTap : null,
                  child: Text('BUY NOW'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(state.book.author!),
                  if (state.book.publishDate != null) ...[LabelText('${state.book.publishDate}')],
                  if (state.book.publisher != null) ...[LabelText('${state.book.publisher}')],
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: BodyText('${state.book.description ?? ''}'),
            ),
          ],
        );
      },
    );
  }

}

