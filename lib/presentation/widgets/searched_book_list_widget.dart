import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchedBookListWidget extends StatelessWidget {
  const SearchedBookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchBookProvider>(context, listen: false);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        itemCount: provider.books.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, idx) =>
            BookTileWidget(book: provider.books[idx]),
      ),
    );
  }
}
