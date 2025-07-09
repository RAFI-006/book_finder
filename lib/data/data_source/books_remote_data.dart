import 'package:book_finder/data/data.dart';
import 'package:dio/dio.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> searchBooks(String query, int page);
  Future<BookModel> getBookDetails(String bookId);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;

  static const String _baseUrl = 'https://openlibrary.org';

  BookRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BookModel>> searchBooks(String query, int page) async {
    try {
      final response = await dio.get(
        '$_baseUrl/search.json',
        queryParameters: {'q': query, 'limit': '10', 'offset': page},
      );
      if (response.statusCode == 200) {
        final List<dynamic> docs = response.data['docs'];
        return docs.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to connect to API: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<BookModel> getBookDetails(String bookId) async {
    try {
      // Open Library uses /works/ for book details
      final response = await dio.get('$_baseUrl/works/$bookId.json');
      if (response.statusCode == 200) {
        return BookModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load book details: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to connect to API for details: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
