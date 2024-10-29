import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dealer.dart';
import '../viewmodels/dealer_viewmodel.dart';
import '../widgets/dealer_card.dart'; // Import your Dealer model

class DealerListView extends StatefulWidget {
  @override
  _DealerListViewState createState() => _DealerListViewState();
}

class _DealerListViewState extends State<DealerListView> {
  @override
  void initState() {
    super.initState();
    // Load dealers when the widget is first created
    final dealerViewModel = Provider.of<DealerViewModel>(context, listen: false);
    dealerViewModel.loadDealers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dealers",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<DealerViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.errorMessage!.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.dealers.isEmpty) {
            return Center(child: Text('No dealers found'));
          }

          return ListView.builder(
            itemCount: viewModel.dealers.length,
            itemBuilder: (context, index) {
              Dealer dealer = viewModel.dealers[index];
              return DealerCard(dealer: dealer); // Custom card widget
            },
          );
        },
      ),
    );
  }
}

