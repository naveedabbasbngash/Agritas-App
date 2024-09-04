import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProblemCard extends StatefulWidget {
  final String image; // Image URL
  final String title;

  const ProblemCard({
    required this.image,
    required this.title,
  });

  @override
  _ProblemCardState createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 00), // Animation duration
      vsync: this,
    );

    // Define a scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),  // Start the scale animation on tap down
      onTapUp: (_) {
        _controller.reverse(); // Reverse the animation on tap up
        // Here you can add any onTap action like navigating to another page
      },
      onTapCancel: () => _controller.reverse(), // Reverse the animation if the tap is canceled
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          color: Colors.white, // Set the background color to white
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: "http://agritas.com.pk/" + widget.image,
                  fit: BoxFit.contain, // Ensure the image is centered and fits within the card
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Show a loading indicator
                  errorWidget: (context, url, error) => Icon(Icons.error), // Show an error icon if the image fails to load
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
