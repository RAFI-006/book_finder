import 'package:book_finder/domain/domain.dart';
import 'package:flutter/material.dart';

enum BookState { initial, loading, loaded, error }

class SearchBookProvider extends ChangeNotifier {
  final SearchBooks searchBooks;
  final GetBookDetails getBookDetails;
  SearchBookProvider({required this.searchBooks, required this.getBookDetails});

  BookState _viewState = BookState.initial;
  BookState get viewState => _viewState;

  List<BookEntity> _books = [];
  List<BookEntity> get books => _books;

  List<BookEntity> _savedBooks = [];
  List<BookEntity> get savedBooks => _savedBooks;

  BookEntity? _selectedBookDetails;
  BookEntity? get selectedBookDetails => _selectedBookDetails;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ///Pagination Part
  int _currentPage = 1;
  String _currentQuery = '';
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  ///Fetch books with pagination
  Future<void> fetchBooks(String query, {bool isRefresh = false}) async {
    if (query.isEmpty) {
      _books = [];
      _viewState = BookState.initial;
      notifyListeners();
      return;
    }

    if (isRefresh) {
      _currentPage = 1;
      _books = [];
      _hasMore = true;
    } else if (!_hasMore) {
      return; // No more data to load
    }

    if (_currentQuery != query) {
      _currentPage = 1;
      _books = [];
      _hasMore = true;
      _currentQuery = query;
    }

    _viewState = BookState.loading;
    notifyListeners();

    try {
      final newBooks = await searchBooks.call(query, _currentPage);
      if (newBooks.isEmpty) {
        _hasMore = false;
      } else {
        _books.addAll(newBooks);
        _currentPage++;
      }
      _viewState = BookState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _viewState = BookState.error;
    } finally {
      notifyListeners();
    }
  }

  void loadMoreBooks(String query) {
    if (_viewState != BookState.loading && _hasMore) {
      fetchBooks(query);
    }
  }

  Future<void> fetchBookDetails(String bookId) async {
    _viewState = BookState.loading;
    _selectedBookDetails = null; // Clear previous details
    notifyListeners();

    try {
      // Call the getBookDetails method on the injected BookRepository
      _selectedBookDetails = await getBookDetails.call(bookId);
      _viewState = BookState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _viewState = BookState.error;
    } finally {
      notifyListeners();
    }
  }
}
