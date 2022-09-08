import 'package:book_store/domain/dto/book_page_dto.dart';
import 'package:book_store/domain/entities/book.dart';
import 'package:book_store/domain/util/normalized_exception.dart';
import 'package:book_store/infrastructure/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../shared/snackbar_widget.dart';

class BookListState extends ChangeNotifier {
  BookListState(this.context) {
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent && !_isLastPage) {
        page += maxResults;
        fetch();
      }
    });

    fetch();
  }

  final ScrollController controller = ScrollController();
  final BuildContext context;
  final List<Book> books = [];

  var _loading = true;
  var _isLastPage = false;
  var _onlyFavorite = true;

  var page = 0;
  final int maxResults = 12;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  fetchPage() async {
    try {
      var api = Provider.of<Api>(context, listen: false);
      BookPageDto dto = await api.fetch(page, maxResults);

      _isLastPage = dto.items == null;
      books.addAll(dto.toBookList());

    } on NormalizedException catch (e) {
      ScaffoldMessenger
          .of(context)
          .showSnackBar(dSnackbar(e.message));
    } catch(_) {
      ScaffoldMessenger
          .of(context)
          .showSnackBar(dSnackbar(dMessageError));
    }
  }

  fetchFavorites(List<String> favorites) async {
    var api = Provider.of<Api>(context, listen: false);

    try {
      var dtos = <BookItemDto>[];
      var futures = <Future>[];

      if (favorites.length <= page) return;

      var range = maxResults + page;
      if (range > favorites.length) range = favorites.length;

      favorites.getRange(page, range)
          .forEach((id) {
        futures.add(api.getById(id)..then((value) => dtos.add(value)));
      });

      await Future.wait(futures);
      books.addAll(dtos.map((e) => e.toBookItem()).toList());

    } on NormalizedException catch (e) {
      ScaffoldMessenger
          .of(context)
          .showSnackBar(dSnackbar(e.message));
    } catch(_) {
      ScaffoldMessenger
          .of(context)
          .showSnackBar(dSnackbar(dMessageError));
    }
  }


  fetch() async {
    loading = true;

    var fService = Provider.of<FavoriteService>(context, listen: false);
    var ids = await fService.getAllIdentifiers();

    if (_onlyFavorite) {
      await fetchFavorites(ids);
    } else {
      await fetchPage();
    }

    for (var i = 0; i < books.length; i++)
      books[i].isFavorite = ids.contains(books[i].id);

    loading = false;
  }

  onBookTap() {
    // TODO: not yet implemented
  }

  onFavoriteItemTap(Book b) async {
    var service = Provider.of<FavoriteService>(context, listen: false);

    if (b.isFavorite)
      await service.remove(b.id!);
    else
      await service.save(b.id!);

    for (var i = 0; i < books.length; i++) {
      if (books[i] == b) {
        books[i].isFavorite = !b.isFavorite;
        notifyListeners();
        break;
      }
    }
  }

  applyFilters() async {
    page = 0;
    books.clear();
    await fetch();
  }

  bool get loading => _loading;

  set loading(bool v) {
    _loading = v;
    notifyListeners();
  }

  bool get onlyFavorite => _onlyFavorite;

  set onlyFavorite(value) {
    _onlyFavorite = value;
    applyFilters();
  }
}
