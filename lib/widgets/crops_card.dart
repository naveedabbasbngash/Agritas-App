import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';

class CropCard extends StatefulWidget {
  final String image; // This is the URL for the image
  final String title;
  final String description;
  final Function onTap; // Callback function to navigate to crop detail

  const CropCard({
    required this.image,
    required this.title,
    required this.description,
    required this.onTap, // Adding onTap function to navigate
  });

  @override
  _CropCardState createState() => _CropCardState();
}

class _CropCardState extends State<CropCard> {
  Color? dominantColor;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider('http://agritas.com.pk/' + widget.image),
    );

    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color.withOpacity(0.7) ?? Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(), // Navigate to detail view when tapped
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: dominantColor ?? Colors.white, // Use dominant color or white
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
                maxLines: 2, // Limit to 2 lines
                overflow: TextOverflow.ellipsis, // Show '...' for overflow
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: 'http://agritas.com.pk/' + widget.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
