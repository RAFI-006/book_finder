import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';

class SavedBookListWidget extends StatelessWidget {
  const SavedBookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, idx) => BookTileWidget(
          imageUrl: 'https://covers.openlibrary.org/b/id/14627060-L.jpg',
          authorName: 'Nolan',
          bookTitle: 'IntersTeller',
        ),
      ),
    );
  }
}
