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
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(book.thumbnail!),
            fit: BoxFit.cover
          )
        ),
      )
    );
  }
}
