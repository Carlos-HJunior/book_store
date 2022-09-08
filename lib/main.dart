import 'package:book_store/infrastructure/services.dart';
import 'package:book_store/infrastructure/services/favorite_cache_service.dart';
import 'package:book_store/presentation/router/book_store_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'infrastructure/services/browser_service.dart';
import 'infrastructure/services/google_api.dart';

void main() {
  runApp(BookStore());
}

const dMessageError = 'Internal error. Please contact system administrator.';

class BookStore extends StatelessWidget {
  BookStore({Key? key}) : super(key: key);

  final dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: true,
      contentType: "application/json",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Api>(create: (_) => newGoogleBooksApi(dio)),
        Provider<FavoriteService>(create: (_) => newFavoriteCacheService()),
        Provider<BrowserService>(create: (_) => newBrowserService()),
      ],
      child: MaterialApp(
        title: 'Book Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.sourceSansPro().fontFamily,
          textTheme: GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme),
        ),
        routes: BookStoreRouter.routes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
