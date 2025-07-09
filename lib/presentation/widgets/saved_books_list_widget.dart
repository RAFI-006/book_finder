import 'package:book_finder/domain/domain.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';

class SavedBookListWidget extends StatelessWidget {
  const SavedBookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, idx) => BookTileWidget(
          book: BookEntity(id: '', title: '', author: ''),
        ),
      ),
    );
  }
}
