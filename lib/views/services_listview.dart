import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/services_viewmodel.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/services_card.dart';
import 'services_officers.dart';

class ServiceListView extends StatefulWidget {
  @override
  _ServiceListViewState createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<ServiceListView> {
  @override
  void initState() {
    super.initState();
    final serviceViewModel = Provider.of<ServiceViewModel>(context, listen: false);
    serviceViewModel.loadServices();
  }

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    final currentCity = weatherViewModel.cityName ?? "Unknown"; // Fallback if city is null

    return Scaffold(
      appBar: AppBar(
        title: Text("Services", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0fa065),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<ServiceViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.services.isEmpty && viewModel.errorMessage == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null && viewModel.errorMessage!.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage!));
          }
          if (viewModel.services.isEmpty) {
            return Center(child: Text('No services found'));
          }

          return ListView.builder(
            itemCount: viewModel.services.length,
            itemBuilder: (context, index) {
              final service = viewModel.services[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServicesOfficers(
                        image: service.typeImageUrl,
                        title: service.typeName,
                        city: weatherViewModel.cityName ?? "Peshawar", // Use the current or default city
                        typeId: service.typeId,
                        cities: service.cities ?? [], // Pass the list of cities
                      ),
                    ),
                  );                },
                child: ServiceCard(service: service),
              );
            },
          );
        },
      ),
    );
  }
}