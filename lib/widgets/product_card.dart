import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust vertical padding if needed
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // No border radius for full-width effect
        ),
        color: Colors.white,
        elevation: 4, // Shadow for the card
        margin: EdgeInsets.zero, // Ensure the card touches the left and right edges
        child: Container(
          height: 180, // Increase the overall height of the card by approximately 10%
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding for content within the card
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  color: Color(0xFF0fa065),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: CachedNetworkImage(
                    imageUrl: 'https://www.agritas.com.pk/${product.imageUrl}',
                    width: 70,  // Smaller width for the image
                    height: 120, // Increased height for the image
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF0fa065),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/product_place_holder.png',
                      width: 50,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Centers the text vertically
                  children: [
                    Text(
                      product.productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Fresh from sea", // Placeholder for the description
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20.0), // 20sp gap between description and pack size
                    Text(
                      product.packSize,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "1KG",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF0fa065),
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
