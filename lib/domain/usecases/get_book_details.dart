import 'package:book_finder/domain/domain.dart';

class GetBookDetails {
  final BookRepository repository;

  GetBookDetails(this.repository);

  Future<BookEntity> call(String bookId) async {
    return await repository.getBookDetails(bookId);
  }
}
