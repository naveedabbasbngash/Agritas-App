import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/services.dart';
import '../viewmodels/service_provider_viewmodel.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../utils/logger.dart';
import '../widgets/officers_card.dart';

class ServicesOfficers extends StatefulWidget {
  final String image;
  final String title;
  final String city;
  final String typeId;
  final List<City> cities;

  ServicesOfficers({
    required this.image,
    required this.title,
    required this.city,
    required this.typeId,
    required this.cities,
  });

  @override
  _ServicesOfficersState createState() => _ServicesOfficersState();
}

class _ServicesOfficersState extends State<ServicesOfficers> {
  String? selectedCity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the status bar color to match the header section
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green, // Ensure this matches your header
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedCity = widget.city;

    Future.microtask(() {
      Provider.of<WeatherViewModel>(context, listen: false).initializeWeather();
      Provider.of<OfficerViewModel>(context, listen: false).loadOfficers(selectedCity!, widget.typeId);
    });
  }

  void _onCityChanged(String? newCity) {
    setState(() {
      selectedCity = newCity;
      Provider.of<OfficerViewModel>(context, listen: false).loadOfficers(selectedCity!, widget.typeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OfficerViewModel>(context);
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Ensures light icons on the status bar
      child: Scaffold(
        backgroundColor: Colors.green, // Match this with header color for a cohesive look
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/serivesdealers_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // Header Section with Image, Title, and Dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image, color: Colors.white, size: 50),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.green, size: 20),
                              SizedBox(width: 8),
                              DropdownButton<String>(
                                value: selectedCity,
                                icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                                underline: SizedBox(),
                                onChanged: _onCityChanged,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                items: widget.cities.map<DropdownMenuItem<String>>((City city) {
                                  return DropdownMenuItem<String>(
                                    value: city.cityName,
                                    child: Text(city.cityName),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Officer List or Status
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (viewModel.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (viewModel.errorMessage != null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error, color: Colors.red, size: 80),
                                SizedBox(height: 10),
                                Text(
                                  'An error occurred: ${viewModel.errorMessage}',
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        } else if (viewModel.officers.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.inbox, color: Colors.grey, size: 80),
                                SizedBox(height: 10),
                                Text(
                                  'No officers found',
                                  style: TextStyle(color: Colors.grey, fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: viewModel.officers.length,
                            itemBuilder: (context, index) {
                              final officer = viewModel.officers[index];
                              EdgeInsets itemPadding = index.isEven
                                  ? EdgeInsets.fromLTRB(15, 20, 85, 20)
                                  : EdgeInsets.fromLTRB(85, 20, 25, 20);

                              return Padding(
                                padding: itemPadding,
                                child: OfficerCard(officer: officer),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}