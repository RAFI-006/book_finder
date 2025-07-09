import 'package:book_finder/core/core.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBookScreen extends StatefulWidget {
  const SearchBookScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBookScreen> {
  late SearchBookProvider _watcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _watcher = context.watch<SearchBookProvider>();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchBookProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(bookFinder, style: headerTextStyle),
        ),
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
                child: _watcher.viewState == BookState.loading
                    ? ShimmerLoadingWidget()
                    : SearchedBookListWidget(),
              ),

              SizedBox(height: 32),
              if (provider.savedBooks.isNotEmpty) ...{
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(savedBooks, style: mediumTextStyle),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SavedBookListWidget(),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
