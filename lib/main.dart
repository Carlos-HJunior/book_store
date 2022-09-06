import 'package:book_store/presentation/router/book_store_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'infrastructure/services/google_api.dart';

void main() {
  runApp(BookStore());
}

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
        Provider(create: (_) => newGoogleBooksApi(dio))
      ],
      child: MaterialApp(
        title: 'Book Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: BookStoreRouter.routes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
