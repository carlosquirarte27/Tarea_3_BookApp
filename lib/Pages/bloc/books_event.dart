part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class BooksSearchEvent extends BooksEvent {
  final String q;

  const BooksSearchEvent({required this.q});
  @override
  List<Object> get props => [q];
}
