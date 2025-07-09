import 'package:book_finder/domain/domain.dart';

abstract class BookRepository {
  Future<List<BookEntity>> searchBooks(String query, int page);
  Future<BookEntity> getBookDetails(String bookId);
  Future<void> saveBook(BookEntity book);
  Future<List<BookEntity>> getSavedBooks();
}
