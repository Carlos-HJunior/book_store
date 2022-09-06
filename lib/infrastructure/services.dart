
import '../domain/dto/book_page_dto.dart';

abstract class Api {
  Future<BookPageDto> fetch(int index);
}