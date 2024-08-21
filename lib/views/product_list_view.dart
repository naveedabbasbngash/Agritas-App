import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../viewmodels/product_viewmodel.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();

    // Ensure loadProducts is called on initialization
    Future.microtask(() {
      final viewModel = Provider.of<ProductViewModel>(context, listen: false);
      viewModel.loadProducts(); // Trigger the API call
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: viewModel.categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.categories.length,
              itemBuilder: (context, index) {
                final category = viewModel.categories[index];

                return ExpansionTile(
                  title: Text(category.categoryName),
                  children: category.products.map<Widget>((product) {
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: 'https://www.agritas.com.pk/${product.imageUrl}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 10,
                            height: 10,  // Making the loading indicator 10x10 pixels
                            child: CircularProgressIndicator(
                              strokeWidth: 2, // Makes the progress indicator thinner
                              color: Color(0xFF0fa065), // Custom color #0fa065
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/product_place_holder.png', // Path to your default placeholder
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(product.productName),
                      subtitle: Text(product.packSize),
                      onTap: () {
                        // Handle product tap
                      },
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}
