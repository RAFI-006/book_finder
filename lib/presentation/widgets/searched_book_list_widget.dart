import 'package:book_finder/core/constants.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedBookListWidget extends StatelessWidget {
  const SearchedBookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchBookProvider>(context, listen: false);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: provider.books.isEmpty
          ? Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 200,
                width: 200,
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 100, color: Colors.grey),
                    Text(
                      textAlign: TextAlign.center,
                      'Your search result will appear here',
                      style: mediumTextStyle,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: provider.books.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, idx) =>
                  BookTileWidget(book: provider.books[idx]),
            ),
    );
  }
}
