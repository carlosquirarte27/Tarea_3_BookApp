class Book {
  String title;
  String pages;
  String date;
  String desc;
  String bookUrl;
  String? imageUrl;

  Book({
    required this.title,
    required this.date,
    required this.pages,
    required this.desc,
    required this.bookUrl,
    this.imageUrl,
  });

  Book.fromMap(Map<String, dynamic> libro)
      : title = libro['volumeInfo']?['title'] ?? 'No tiene titulo',
        pages = libro['volumeInfo']?['pageCount']?.toString() != null
            ? 'Páginas: ${libro['volumeInfo']['pageCount'].toString()}'
            : 'Número de páginas no disponible.',
        date = libro['volumeInfo']?['publishedDate'] ?? 'No hay año de publicacion',
        imageUrl = libro['volumeInfo']?['imageLinks']?['thumbnail'],
        desc = libro['volumeInfo']?['description'] ?? 'No existe la descripción',
        bookUrl = libro['volumeInfo']?['infoLink'] ?? 'No hay link';
}
