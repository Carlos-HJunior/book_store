import 'package:book_store/domain/entities/book.dart';
import 'package:book_store/infrastructure/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BookListState extends ChangeNotifier {
  ScrollController controller = ScrollController();
  final BuildContext context;
  final List<Book> books = [];
  bool _loading = false;
  var page = 0;
  bool _isLastPage = false;

  BookListState(this.context) {
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent && !_isLastPage) {
        page++;
        fetch();
      }
    });

    fetch();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  fetch() async {
    loading = true;

    var api = Provider.of<Api>(context, listen: false);
    var dto = await api.fetch(page);

    _isLastPage = dto.items == null;
    books.addAll(dto.toBookList());

    loading = false;
  }

  set loading(bool v) {
    _loading = v;
    notifyListeners();
  }

  bool get loading => _loading;
}
