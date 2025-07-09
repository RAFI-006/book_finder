import 'package:book_finder/domain/domain.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookTileWidget extends StatelessWidget {
  final BookEntity book;

  const BookTileWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,

        MaterialPageRoute(builder: (context) => BookDetailsScreen(book: book)),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.0,
        color: Colors.white24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Book Cover Image
            Card(
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: book.coverImageUrl!,
                placeholder: (_, __) => Container(color: Colors.blueGrey),
                errorWidget: (_, __, ____) => Container(color: Colors.grey),
                width: 160,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Author Name
                  SizedBox(
                    width: 160,
                    child: Text(
                      book.author.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  // Book Title
                  SizedBox(
                    width: 160,
                    child: Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,

                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
