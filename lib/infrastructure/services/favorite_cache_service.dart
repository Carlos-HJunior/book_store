import 'package:book_store/infrastructure/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

FavoriteService newFavoriteCacheService() {
  return _FavoriteCacheService();
}

class _FavoriteCacheService implements FavoriteService {
  static const _key = 'favorite-books';

  @override
  Future<List<String>> getAllIdentifiers() async {
    var sp = await SharedPreferences.getInstance();
    return await sp.getStringList(_key) ?? [];
  }

  @override
  Future remove(String id) async {
    var list = await getAllIdentifiers();
    list.removeWhere((it) => it == id);

    return _save(list);
  }

  @override
  Future save(String id) async {
    var list = await getAllIdentifiers();
    list.add(id);

    return _save(list);
  }

  _save(List<String> value) async {
    var sp = await SharedPreferences.getInstance();
    await sp.remove(_key);
    await sp.setStringList(_key, value);
  }
}
