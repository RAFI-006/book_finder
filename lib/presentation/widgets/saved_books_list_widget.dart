import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SavedBookListWidget extends StatelessWidget {
  const SavedBookListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemCount: Provider.of<SearchBookProvider>(
          context,
          listen: false,
        ).savedBooks.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, idx) => BookTileWidget(
          book: Provider.of<SearchBookProvider>(
            context,
            listen: false,
          ).savedBooks[idx],
        ),
      ),
    );
  }
}
