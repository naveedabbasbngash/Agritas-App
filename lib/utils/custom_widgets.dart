import 'package:flutter/material.dart';
import '../models/product.dart';
import '../views/product_details_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(Icons.agriculture), // Assuming no image URL, so using an icon
        title: Text(product.productName),
        subtitle: Text(product.packSize),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsView(product: product),
            ),
          );
        },
      ),
    );
  }
}
