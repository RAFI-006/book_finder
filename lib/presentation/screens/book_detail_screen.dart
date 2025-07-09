import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

class BookDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String coverImageUrl;
  final int reviews;
  final int ratings;
  final double averageRating;

  const BookDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.reviews,
    required this.ratings,
    required this.averageRating,
  });

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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the rotation
    );

    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic, // Smooth animation curve
      ),
    );

    // Start the animation when the widget is initialized
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.favorite, color: Colors.red[700], size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Book Cover Image with Rotation Animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.coverImageUrl,
                      width: MediaQuery.of(context).size.width * 0.55,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Book Title and Series
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              '(Harry Potter #1)', // This can also be passed via constructor if dynamic
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            // Author (Hardcoded for now, can be added to constructor)
            const Text(
              'By J.K. Rowling',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildStarRating(widget.averageRating),
            ),
            const SizedBox(height: 5),
            // Rating Details
            Text(
              'Rating details · ${widget.ratings} ratings · ${widget.reviews} reviews',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // Book Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 50), // Spacing at the bottom
          ],
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
