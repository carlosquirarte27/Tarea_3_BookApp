import 'package:http/http.dart';
import 'dart:convert';
import 'book.dart';

class BookList {
  BookList();

  Future<List<Book>> getAllBooks(String q) async {
    final Uri uri =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': q});
    final Response res =
        await get(uri, headers: {'Content-Type': 'application/json'});
    if (res.statusCode != 200) {
      throw Exception();
    }
    final List<dynamic> items = jsonDecode(res.body)['items'] ?? [];
    return items.map((item) => Book.fromMap(item)).toList();
  }
}
