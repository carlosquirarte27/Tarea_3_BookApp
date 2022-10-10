import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './Pages/bloc/books_bloc.dart';
import './Pages/homePage.dart';
import 'classes/book_list.dart';

void main() => runApp(RepositoryProvider(
      create: (context) => BookList(),
      child: BlocProvider(
        create: (context) => BooksBloc(bookList: context.read<BookList>()),
        child: const MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
        ),
      ),
      home: const HomePage(),
    );
  }
}
