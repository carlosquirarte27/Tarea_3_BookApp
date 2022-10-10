import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../classes/book_list.dart';
import '../../classes/book.dart';

part 'books_event.dart';
part 'books_state.dart';

const String googleApiUrl = 'www.googleapis.com';
const String googleApiUrlPath = '/books/v1/volumes';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BookList bookList;

  BooksBloc({required bookList})
      : bookList = bookList,
        super(BooksInitialState()) {
    on<BooksSearchEvent>(handler);
  }

  FutureOr<void> handler(BooksSearchEvent e, Emitter emit) async {
    emit(BooksSeachingState());
    try {
      final List<Book> books = await bookList.getAllBooks(e.q);
      emit(BooksSearchSuccessState(books: books));
    } on Exception {
      emit(
        const BooksErrorState(
          errorMessage: 'Error!',
        ),
      );
    }
  }
}
