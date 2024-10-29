import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/services_viewmodel.dart';
import '../widgets/services_card.dart'; // Import your ServiceCard widget
import 'services_officers.dart'; // Import ServicesOfficers screen

class ServiceListView extends StatefulWidget {
  @override
  _ServiceListViewState createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<ServiceListView> {
  @override
  void initState() {
    super.initState();
    // Load services when the widget is first created
    final serviceViewModel = Provider.of<ServiceViewModel>(context, listen: false);
    serviceViewModel.loadServices(); // Ensure services are loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0fa065),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<ServiceViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.services.isEmpty && viewModel.errorMessage == null) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator when data is being fetched
          }

          if (viewModel.errorMessage != null && viewModel.errorMessage!.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage!)); // Show error message if there was an issue
          }

          if (viewModel.services.isEmpty) {
            return Center(child: Text('No services found')); // Show message if no services are available
          }

          // Display the list of services
          return ListView.builder(
            itemCount: viewModel.services.length,
            itemBuilder: (context, index) {
              final service = viewModel.services[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to ServicesOfficers and pass image and title
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServicesOfficers(
                        image: service.typeImageUrl, // Replace with actual image property
                        title: service.typeName, // Replace with actual title property
                        officers: [
                          {'name': service.typeName, 'description': service.typeDescription}, // Officer details, if needed
                        ],
                      ),
                    ),
                  );
                },
                child: ServiceCard(service: service), // Custom service card widget
              );
            },
          );
        },
      ),
    );
  }
}
