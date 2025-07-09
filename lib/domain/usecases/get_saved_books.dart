import 'package:book_finder/domain/domain.dart';

class GetSavedBooks {
  final BookRepository repository;

  GetSavedBooks(this.repository);

  Future<List<BookEntity>> call() async {
    return await repository.getSavedBooks();
  }
}
