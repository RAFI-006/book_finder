class BookEntity {
  final String id;
  final String title;
  final String author;
  final String? thumbnailUrl;
  final String? coverImageUrl;
  final String? description;
  final int? firstPublishYear;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    this.thumbnailUrl,
    this.coverImageUrl,
    this.description,
    this.firstPublishYear,
  });
}
