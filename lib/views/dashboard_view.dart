import 'package:agritas_app/viewmodels/crops_viewmodel.dart';
import 'package:agritas_app/views/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../viewmodels/language_viewmodel.dart';
import 'crops_view.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final WeatherViewModel weatherViewModel = WeatherViewModel();

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    await weatherViewModel.fetchLocationAndWeather();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Access the language from the LanguageViewModel
    final languageViewModel = Provider.of<LanguageViewModel>(context);
    final isUrdu = languageViewModel.selectedLanguage == 'ur';

    return Scaffold(
      body: Stack(
        children: [
          // Background colors
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: const Color(0xFF0fa065), // Green portion (40%)
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: const Color(0xFFE1FDF9), // Light blue portion (60%)
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Weather Information
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02, // 5% of the screen height
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherViewModel.currentDate,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              weatherViewModel.cityName ?? (isUrdu ? "لوڈ کر رہا ہے..." : "Loading..."),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              weatherViewModel.weather?.condition ?? (isUrdu ? "لوڈ کر رہا ہے..." : "Loading..."),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${weatherViewModel.weather?.temperature ?? '--'}°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (isUrdu ? "محسوس ${weatherViewModel.weather?.feelsLike ?? '--'}°" : "Real feel ${weatherViewModel.weather?.feelsLike ?? '--'}°"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Scrollable White Decoration Container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // App Logo
                          Container(
                            height: 80,
                            child: Image.asset(
                              'assets/images/language_top_logo.png',
                            ), // Update with your logo asset path
                          ),
                          SizedBox(height: 10),
                          // Animated Slider
                          Container(
                            height: 120.0,
                            color: Colors.grey[300], // Placeholder for slider
                            child: Center(
                              child: Text(isUrdu ? "سلائیڈر پلیس ہولڈر" : "Slider Placeholder"),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Responsive GridView of boxes
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // 3 items per row
                              mainAxisSpacing: 20.0, // Spacing between rows
                              crossAxisSpacing: 20.0, // Spacing between columns
                              childAspectRatio: 0.65, // Height is greater than width
                            ),
                            itemCount: 6, // Number of buttons
                            itemBuilder: (context, index) {
                              final titlesEn = [
                                'Products',
                                'Crops',
                                'Problems',
                                'Dealers',
                                'Contact',
                                'Services'
                              ];
                              final titlesUr = [
                                'مصنوعات',
                                'فصلیں',
                                'مسائل',
                                'ڈیلر',
                                'رابطہ کریں',
                                'خدمات'
                              ];
                              final icons = [
                                'assets/images/products_icon.png',
                                'assets/images/crops_image.png',
                                'assets/images/question_icon.png',
                                'assets/images/haryali_icon.png',
                                'assets/images/contact_icon.png',
                                'assets/images/services_icon.png',
                              ];
                              final colors = [
                                Colors.orange,
                                Colors.green,
                                Colors.purple,
                                Colors.yellow,
                                Colors.blue,
                                Colors.orangeAccent,
                              ];

                              return GestureDetector(
                                onTap: () {
                                  print('Clicked on ${titlesEn[index]}');
                                  switch (index) {
                                    case 0:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProductListView()),
                                      );
                                      break;
                                    case 1:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CropView()),
                                      );
                                      break;
                                    default:
                                      print("unknown item clicked");
                                  }
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors[index],
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 70,  // Adjust the size of the white circle
                                            width: 70,   // Ensure the circle is proportional
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                icons[index],
                                                height: 40,  // Adjust the size of the icon within the circle
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8), // Space between the box and the text
                                    Text(
                                      isUrdu ? titlesUr[index] : titlesEn[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
