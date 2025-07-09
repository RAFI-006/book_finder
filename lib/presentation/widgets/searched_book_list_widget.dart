import 'package:book_finder/core/core.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedBookListWidget extends StatefulWidget {
  const SearchedBookListWidget({super.key});

  @override
  State<SearchedBookListWidget> createState() => _SearchedBookListWidgetState();
}

class _SearchedBookListWidgetState extends State<SearchedBookListWidget> {
  final ScrollController _scrollController = ScrollController();
  late SearchBookProvider provider;
  @override
  void initState() {
    super.initState();
    provider = context.read<SearchBookProvider>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      provider.loadMoreBooks(provider.currentQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      searchResultAppearHere,
                      style: mediumTextStyle,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount:
                  provider.books.length +
                  (provider.viewState == BookState.onScroll &&
                          provider.books.isNotEmpty
                      ? 1
                      : 0),
              shrinkWrap: true,
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, idx) => (idx < provider.books.length)
                  ? BookTileWidget(book: provider.books[idx])
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ),
    );
  }
}
