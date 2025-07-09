import 'package:book_finder/core/core.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/material.dart';

class SearchBookScreen extends StatefulWidget {
  const SearchBookScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(bookFinder, style: headerTextStyle)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            SearchBarWidget(),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(searchResult, style: mediumTextStyle),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SearchedBookListWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(savedBooks, style: mediumTextStyle),
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SavedBookListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
