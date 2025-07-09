import 'package:book_finder/domain/domain.dart';

class SaveBook {
  final BookRepository repository;

  SaveBook(this.repository);

  Future<void> call(BookEntity book) async {
    await repository.saveBook(book);
  }
}
