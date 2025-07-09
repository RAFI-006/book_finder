import 'package:book_finder/core/core.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

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
          decoration: InputDecoration(
            hintText: searchTitle,
            hintStyle: TextStyle(color: kcMediumGrey),
            prefixIcon: Icon(Icons.search, color: kcMediumGrey),
            suffixIcon: Icon(Icons.mic, color: kcMediumGrey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          ),
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
