import 'package:book_finder/domain/domain.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, idx) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: BookTileWidget(
              book: BookEntity(
                id: '',
                title: 'Harry potter',
                author: 'jk rowling',
                coverImageUrl:
                    'https://covers.openlibrary.org/b/id/14627060-L.jpg',
              ),
            ),
          );
        },
      ),
    );
  }
}
