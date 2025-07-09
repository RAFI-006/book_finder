import 'package:book_finder/domain/domain.dart';

class SearchBooks {
  final BookRepository repository;

  SearchBooks(this.repository);

  Future<List<BookEntity>> call(String query, int page) async {
    return await repository.searchBooks(query, page);
  }
}
