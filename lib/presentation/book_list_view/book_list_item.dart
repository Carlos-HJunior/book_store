import 'package:book_store/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    required this.book,
    required this.onTap,
  });

  final Book book;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(book.thumbnail!),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title!,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(book.author!),
                        if (book.publishDate != null) ...[Text('${book.publishDate}')],
                        if (book.publisher != null) ...[Text('${book.publisher}')],
                      ],
                    ),
                  ),
                  Text(book.visualPrice),
                ],
              ),
            ),
          ),
          Container(
            child: Icon(Icons.bookmark_border),
          )
        ],
      ),
    );
  }
}
