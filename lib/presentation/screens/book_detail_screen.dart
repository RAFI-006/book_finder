import 'package:book_finder/core/core.dart';
import 'package:book_finder/domain/domain.dart';
import 'package:book_finder/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BookDetailsScreen extends StatefulWidget {
  final BookEntity book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchBookProvider>(
        context,
        listen: false,
      ).fetchBookDetails(widget.book.id);
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: math.pi), weight: 50),
          TweenSequenceItem(tween: Tween(begin: math.pi, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var watcher = Provider.of<SearchBookProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: () => Provider.of<SearchBookProvider>(context, listen: false)
              .saveBookToLocal(widget.book)
              .then((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SearchBookScreen()),
                  (route) => false,
                );
              }),
          child: Container(
            height: 56,
            color: Colors.black87,
            child: Center(
              child: Text(
                saveThisBook,
                style: mediumTextStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final angle = _animation.value;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.book.coverImageUrl ?? '',
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(height: 200, color: Colors.blueGrey),
                        errorWidget: (_, __, ___) =>
                            Container(height: 200, color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.book.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                'by',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                widget.book.author,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildStarRating(5),
              ),
              const SizedBox(height: 5),
              Text(
                'Publishing year · ${widget.book.firstPublishYear} year.',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              if (watcher.viewState == BookState.loading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Text(shimmerDummyText),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    watcher.selectedBookDetails?.description ?? '',
                    textAlign: TextAlign.justify,
                    style: descTextStyle,
                  ),
                ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStarRating(double averageRating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < averageRating.floor()) {
        stars.add(const Icon(Icons.star, color: Colors.orange, size: 20));
      } else if (i < averageRating && averageRating - i > 0.5) {
        stars.add(const Icon(Icons.star_half, color: Colors.orange, size: 20));
      } else {
        stars.add(
          const Icon(Icons.star_border, color: Colors.orange, size: 20),
        );
      }
    }
    stars.add(const SizedBox(width: 8));
    stars.add(
      Text(
        averageRating.toStringAsFixed(2),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
    return stars;
  }
}
