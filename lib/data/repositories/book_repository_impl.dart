import 'package:book_finder/data/data.dart';
import 'package:book_finder/domain/domain.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<BookEntity>> searchBooks(String query, int page) async {
    return await remoteDataSource.searchBooks(query, page);
  }

  @override
  Future<BookEntity> getBookDetails(String bookId) async {
    return await remoteDataSource.getBookDetails(bookId);
  }

  @override
  Future<void> saveBook(BookEntity book) async {
    if (book is BookModel) {
      await localDataSource.saveBook(book);
    } else {
      // Convert Book entity to BookModel if it's not already
      final bookModel = BookModel(
        id: book.id,
        title: book.title,
        author: book.author,
        thumbnailUrl: book.thumbnailUrl,
        coverImageUrl: book.coverImageUrl,
        description: book.description,
        firstPublishYear: book.firstPublishYear,
      );
      await localDataSource.saveBook(bookModel);
    }
  }

  @override
  Future<List<BookEntity>> getSavedBooks() async {
    return await localDataSource.getSavedBooks();
  }
}
