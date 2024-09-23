import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../viewmodels/language_viewmodel.dart';
import '../views/product_details_view.dart'; // Import ProductDetailsView

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final languageViewModel = Provider.of<LanguageViewModel>(context);
    final isUrdu = languageViewModel.selectedLanguage == 'ur';

    return GestureDetector(
      onTap: () {
        // Navigate to ProductDetailsView when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: Colors.white,
          elevation: 6,
          child: Container(
            height: 180,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                _buildProductImage(),
                SizedBox(width: 16.0),
                _buildProductDetails(context, isUrdu),
                _buildArrowIcon(isUrdu),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: Color(0xFF0fa065),
        padding: EdgeInsets.all(12.0),
        child: CachedNetworkImage(
          imageUrl: 'https://www.agritas.com.pk/${product.imageUrl}',
          width: 70,
          height: 120,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/product_place_holder.png',
            width: 70,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, bool isUrdu) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isUrdu ? product.urProductName : product.productName,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.0),
          Text(
            isUrdu ? product.compositionUr : product.composition,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16.0),
          Text(
            product.packSize,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 4.0),
          const Text(
            "1KG",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildArrowIcon(bool isUrdu) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Icon(
        isUrdu ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
        color: Color(0xFF0fa065),
        size: 24.0,
      ),
    );
  }
}
