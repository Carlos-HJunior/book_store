class Book {
  Book(
    this.id,
    this.thumbnail,
    this.title,
    this.author,
    this.price,
    this.currency,
    this.publishDate,
    this.publisher,
  );

  bool isFavorite = false;

  final String? id;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other)
          || other is Book
          && runtimeType == other.runtimeType
          && id == other.id;

  @override
  int get hashCode => id.hashCode;
}