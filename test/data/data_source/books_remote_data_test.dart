// test/data/datasources/remote/book_remote_datasource_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'mock_dio.dart';
import 'package:book_finder/data/data.dart'; // Make sure this includes BookRemoteDataSourceImpl and BookModel

void main() {
  late BookRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = BookRemoteDataSourceImpl(mockDio);
  });

  group('searchBooks', () {
    const tQuery = 'flutter';
    const tPage = 1;

    const tBookModels = [
      BookModel(
        id: 'OL1234W',
        title: 'Flutter Basics',
        author: 'John Doe',
        thumbnailUrl: 'https://covers.openlibrary.org/b/id/123-S.jpg',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/123-L.jpg',
      ),
      BookModel(
        id: 'OL5678W',
        title: 'Advanced Flutter',
        author: 'Jane Smith',
        thumbnailUrl: 'https://covers.openlibrary.org/b/id/456-S.jpg',
        coverImageUrl: 'https://covers.openlibrary.org/b/id/456-L.jpg',
      ),
    ];

    test('should return List<BookModel> when status code is 200', () async {
      //Stubbing mocks
      when(
        mockDio.get(
          'https://openlibrary.org/search.json',
          queryParameters: argThat(
            equals({'q': 'harry potter', 'limit': '10', 'offset': 1}),
            named: 'queryParameters',
          ),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: 'https://openlibrary.org/search.json',
          ),
          data: {
            'docs': [
              {
                'key': '/works/OL1234W',
                'title': 'Harry Potter and the Sorcerer\'s Stone',
                'author_name': ['J.K. Rowling'],
                'cover_i': 123,
              },
            ],
          },
          statusCode: 200,
        ),
      );

      final result = await dataSource.searchBooks(tQuery, tPage);

      expect(result, equals(tBookModels));
      verify(
        mockDio.get(
          'https://openlibrary.org/search.json',
          queryParameters: {'q': tQuery, 'page': tPage},
        ),
      );
      verifyNoMoreInteractions(mockDio);
    });

    test('should throw Exception when response code is not 200', () async {
      when(
        mockDio.get(
          'https://openlibrary.org/search.json',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: 'Something went wrong',
          statusCode: 404,
        ),
      );

      expect(
        () => dataSource.searchBooks(tQuery, tPage),
        throwsA(isA<Exception>()),
      );

      verify(
        mockDio.get(
          'https://openlibrary.org/search.json',
          queryParameters: {'q': tQuery, 'page': tPage},
        ),
      );
      verifyNoMoreInteractions(mockDio);
    });

    test('should throw Exception when Dio throws DioException', () async {
      when(
        mockDio.get(
          'https://openlibrary.org/search.json',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Network error',
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () => dataSource.searchBooks(tQuery, tPage),
        throwsA(isA<Exception>()),
      );

      verify(
        mockDio.get(
          'https://openlibrary.org/search.json',
          queryParameters: {'q': tQuery, 'page': tPage},
        ),
      );
      verifyNoMoreInteractions(mockDio);
    });
  });
}
