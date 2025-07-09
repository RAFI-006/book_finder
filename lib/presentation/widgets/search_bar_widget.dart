import 'package:book_finder/core/core.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onSubmitted: (val) {
            if (val.length > 4) {
              Provider.of<SearchBookProvider>(
                context,
                listen: false,
              ).fetchBooks(val);
            }
          },
          decoration: InputDecoration(
            hintText: searchTitle,
            hintStyle: TextStyle(color: kcMediumGrey),
            prefixIcon: Icon(Icons.search, color: kcMediumGrey),
            suffixIcon: IconButton(
              onPressed: () {
                Provider.of<SearchBookProvider>(
                  context,
                  listen: false,
                ).fetchBooks(_searchController.text);
              },
              icon: Icon(Icons.arrow_forward, color: kcMediumGrey),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          ),
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}
