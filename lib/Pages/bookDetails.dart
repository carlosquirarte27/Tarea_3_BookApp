import 'package:flutter/material.dart';
import 'package:book_app/Components/text.dart';
import '../../classes/book.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;
  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles'), actions: [
        IconButton(
            onPressed: () {
              if (book.bookUrl != 'Link no disponible.') {
                launchUrlString(
                  book.bookUrl,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('No hay link'),
                    ),
                  );
              }
            },
            icon: const Icon(Icons.public)),
        IconButton(
            onPressed: () {
              Share.share(
                  '\'${book.title}\' (${book.pages}) disponible en: ${book.bookUrl}',
                  subject: 'Compartir libro');
            },
            icon: const Icon(Icons.share)),
      ]),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .35 > 200 ? height * .35 : 200,
                child: AspectRatio(
                  aspectRatio: 9 / 14,
                  child: book.imageUrl != null
                      ? Image.network(
                          book.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/noImage.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Center(
                  child: ExpandableDescription(
                    text: book.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    book.date,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.pages,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ExpandableDescription(
                    text: book.desc,
                    maxLines: 10,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
