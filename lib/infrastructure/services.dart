import '../domain/dto/book_page_dto.dart';

abstract class Api {
  Future<BookPageDto> fetch(int index, int maxResults);
  Future<BookItemDto> getById(String id);
}

abstract class FavoriteService {
  Future save(String id);
  Future remove(String id);
  Future<List<String>> getAllIdentifiers();
}

abstract class BrowserService {
  Future tryLaunch(String url);
}