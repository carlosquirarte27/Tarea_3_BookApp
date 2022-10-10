import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import './bloc/books_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bookDetails.dart';
import 'bookTile.dart';
import 'empty.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchQueyController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 13, right: 13),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                context.read<BooksBloc>().add(
                      BooksSearchEvent(
                        q: searchQueyController.text,
                      ),
                    );
              },
              controller: searchQueyController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('Buscar'),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<BooksBloc>().add(
                          BooksSearchEvent(
                            q: searchQueyController.text,
                          ),
                        );
                  },
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          BlocConsumer<BooksBloc, BooksState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is BooksInitialState) {
                return const Expanded(
                  child: Center(
                    child: Text('Ingresa un título'),
                  ),
                );
              } else if (state is BooksSeachingState) {
                return Expanded(
                  child: Shimmer.fromColors(
                    period: const Duration(milliseconds: 1500),
                    highlightColor: const Color.fromARGB(155, 240, 240, 240),
                    baseColor: const Color.fromARGB(160, 195, 195, 195),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          return const EmptyTile();
                        },
                      ),
                    ),
                  ),
                );
              } else if (state is BooksErrorState) {
                return Expanded(
                  child: Center(
                    child: Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (state is BooksSearchSuccessState) {
                if (state.books.isNotEmpty) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: state.books.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailsPage(
                                      book: state.books[index],
                                    ),
                                  ),
                                );
                              },
                              child: BookTile(book: state.books[index]));
                        },
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Not found',
                      ),
                    ),
                  );
                }
              } else {
                return const Expanded(
                  child: Center(
                    child: Text(
                      'Unknown error.',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
