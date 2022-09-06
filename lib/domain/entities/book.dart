

class Book {
  Book(
    this.thumbnail,
    this.title,
    this.author,
    this.price,
    this.currency,
    this.publishDate,
    this.publisher,
  );

  final String? thumbnail;
  final String? title;
  final String? author;
  final double? price;
  final String? currency;
  final String? publishDate;
  final String? publisher;

  String get visualPrice {
    if (price == null || currency == null)
      return 'Unavailable';

    return '$currency ${price!.toStringAsFixed(2)}';
  }
}
