import 'package:book_store/domain/entities/book.dart';
import 'package:book_store/domain/util/normalized_exception.dart';
import 'package:book_store/infrastructure/services.dart';
import 'package:book_store/presentation/shared/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class BookDetailState extends ChangeNotifier {
  BookDetailState(this.context, this.book);

  final BuildContext context;
  final Book book;
  bool needReload = false;

  Future onFavoriteItemTap() async {
    var service = Provider.of<FavoriteService>(context, listen: false);

    if (book.isFavorite) await service.remove(book.id!);
    else await service.save(book.id!);

    book.isFavorite = !book.isFavorite;
    needReload = true;
    notifyListeners();
  }

  Future onBuyTap() async {
    try {
      var service = Provider.of<BrowserService>(context, listen: false);
      await service.tryLaunch(book.buyLink!);
    } on NormalizedException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(dSnackbar(e.message));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(dSnackbar(dMessageError));
    }
  }
}
