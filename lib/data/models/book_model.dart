import 'package:book_finder/domain/domain.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    super.thumbnailUrl,
    super.coverImageUrl,
    super.description,
    super.firstPublishYear,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final coverId = json['cover_i'];
    final thumbnailUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-L.jpg' // Small thumbnail
        : null;
    final coverImageUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-L.jpg' // Large cover
        : null;

    // Handle authors, which can be a list or a single string
    String author = 'Unknown Author';
    if (json['author_name'] != null) {
      if (json['author_name'] is List) {
        author = (json['author_name'] as List).join(', ');
      } else {
        author = json['author_name'].toString();
      }
    } else if (json['authors'] != null) {
      // For details API
      if (json['authors'] is List) {
        final authorsList = (json['authors'] as List)
            .map((e) => e['name'] as String?)
            .whereType<String>()
            .toList();
        if (authorsList.isNotEmpty) {
          author = authorsList.join(', ');
        }
      }
    }

    // Handle description, which can be a string or a map
    String? description;
    if (json['description'] != null) {
      if (json['description'] is String) {
        description = json['description'] as String;
      } else if (json['description'] is Map &&
          json['description']['value'] is String) {
        description = json['description']['value'] as String;
      }
    }

    return BookModel(
      id:
          json['key']?.toString().split('/').last ??
          json['id']?.toString() ??
          '', // key is like /works/OL1234W
      title: json['title'] as String? ?? 'No Title',
      author: author,
      thumbnailUrl: thumbnailUrl,
      coverImageUrl: coverImageUrl,
      description: description,
      firstPublishYear: json['first_publish_year'] as int?,
    );
  }

  // Convert BookModel to a Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'thumbnailUrl': thumbnailUrl,
      'coverImageUrl': coverImageUrl,
      'description': description,
      'firstPublishYear': firstPublishYear,
    };
  }

  // Create BookModel from a Map retrieved from SQLite
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String?,
      coverImageUrl: map['coverImageUrl'] as String?,
      description: map['description'] as String?,
      firstPublishYear: map['firstPublishYear'] as int?,
    );
  }
}
