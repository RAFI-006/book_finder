import 'package:book_finder/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookTileWidget extends StatelessWidget {
  final String imageUrl;
  final String authorName;
  final String bookTitle;

  const BookTileWidget({
    super.key,
    required this.imageUrl,
    required this.authorName,
    required this.bookTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BookDetailsScreen(
            title: 'Zazbaati Insaan',
            description:
                'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
            coverImageUrl: 'https://covers.openlibrary.org/b/id/14627060-L.jpg',
            reviews: 7,
            ratings: 9,
            averageRating: 5,
          ),
        ),
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
              child: Expanded(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,

                  width: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Author Name
                  Text(
                    authorName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.0),
                  // Book Title
                  Text(
                    bookTitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 1,
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
