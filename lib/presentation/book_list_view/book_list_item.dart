import 'package:book_store/domain/entities/book.dart';
import 'package:flutter/material.dart';

import '../shared/text_widget.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    required this.book,
    this.onTap,
    this.onFavoriteTap,
  });

  final Book book;
  final Function()? onTap;
  final Function(Book)? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 158,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(book.thumbnail!, fit: BoxFit.contain),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _BookInfo(book),
                ),
              ),
              IconButton(
                onPressed: () => onFavoriteTap?.call(book),
                icon: Icon(
                  book.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookInfo extends StatelessWidget {
  _BookInfo(this.book);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseTitle(book.title!),
              LabelText(book.author!),
              if (book.publishDate != null) ...[LabelText('${book.publishDate}')],
              if (book.publisher != null) ...[LabelText('${book.publisher}')],
            ],
          ),
        ),
        LabelText(book.visualPrice),
      ],
    );
  }
}
