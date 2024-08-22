import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';
import '../viewmodels/language_viewmodel.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/header.dart';
import '../widgets/product_card.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    // Ensure loadProducts is called on initialization
    Future.microtask(() async {
      final viewModel = Provider.of<ProductViewModel>(context, listen: false);
      await viewModel.loadProducts();

      if (viewModel.categories.isNotEmpty && mounted) {
        setState(() {
          _tabController = TabController(
            length: viewModel.categories.length,
            vsync: this,
          );

          // Listen to tab index changes to update UI
          _tabController!.addListener(() {
            setState(() {});
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);
    final languageModel = Provider.of<LanguageViewModel>(context);

    if (_tabController == null || viewModel.categories.isEmpty) {
      return Scaffold(
        backgroundColor: Color(0xFFE1FDF9),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      length: viewModel.categories.length,
      child: Scaffold(
        backgroundColor: Color(0xFFE1FDF9), // Set the background color for the whole screen
        body: Column(
          children: [
            CustomHeader(
              title: languageModel.selectedLanguage == 'en' ? 'Products' : 'مصنوعات',
              onBackPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icons.arrow_back,  // Ensure the icon remains on the left
            ),
            // Categories TabBar below the green area
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 0), // Add margin to position it below the green area
              child: CustomTabBar(
                controller: _tabController!,
                tabs: viewModel.categories.map((category) {
                  return Text(
                    languageModel.selectedLanguage == 'en'
                        ? category.categoryName
                        : category.urCategoryName,
                  );
                }).toList(),
                selectedColor: Color(0xFF0fa065), // Green color for selected tab background
                unselectedColor: Colors.transparent, // Transparent for unselected tabs
                borderColor: Colors.grey, // Border color for unselected tabs
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController!,
                children: viewModel.categories.map((category) {
                  return ListView.builder(
                    itemCount: category.products.length,
                    itemBuilder: (context, index) {
                      final product = category.products[index];
                      return ProductCard(product: product);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
