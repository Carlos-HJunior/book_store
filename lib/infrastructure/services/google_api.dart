import 'dart:io';

import 'package:book_store/domain/dto/book_page_dto.dart';
import 'package:book_store/domain/util/normalized_exception.dart';
import 'package:book_store/infrastructure/services.dart';
import 'package:dio/dio.dart';

Api newGoogleBooksApi(Dio dio) => _GoogleBooksApi(dio);

class _GoogleBooksApi implements Api {
  static const baseUrl = 'https://www.googleapis.com';

  final Dio dio;

  _GoogleBooksApi(this.dio) {
    dio.options.baseUrl = baseUrl;
  }

  @override
  Future<BookPageDto> fetch(int index, int maxResults) async {
    var response = await dio.get(
      '/books/v1/volumes',
      queryParameters: {
        'q': 'mobile+development',
        'maxResults': maxResults,
        'startIndex': index,
      },
    );

    if (response.statusCode != HttpStatus.ok)
      throw const NormalizedException('error when fetching page');

    return BookPageDto.fromJson(response.data);
  }

  @override
  Future<BookItemDto> getById(String id) async {
    var response = await dio.get('/books/v1/volumes/${id}');

    if (response.statusCode != HttpStatus.ok)
      throw const NormalizedException('error when fetching page');

    return BookItemDto.fromJson(response.data);
  }
}
