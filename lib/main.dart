import 'package:agritas_app/models/problems.dart';
import 'package:agritas_app/viewmodels/crops_viewmodel.dart';
import 'package:agritas_app/viewmodels/problem_viewmodel.dart';
import 'package:agritas_app/views/crops_view.dart';
import 'package:agritas_app/views/language_selection_view.dart';
import 'package:agritas_app/views/problem_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/crops.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/language_viewmodel.dart';
import 'viewmodels/weather_viewmodel.dart';  // Import the WeatherViewModel
import 'views/dashboard_view.dart';
import 'models/product.dart';
import 'models/category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(CropAdapter());
  Hive.registerAdapter(ProblemAdapter());
  Hive.registerAdapter(ProblemCategoryAdapter());


  await Hive.openBox<Crop>('cropsBox');
  await Hive.openBox<Category>('ProductBox');
  await Hive.openBox<ProblemCategory>('ProblemBox');

  // Ensure location services are enabled and permissions are granted
  await _initializeLocationServices();

  runApp(MyApp());
}

Future<void> _initializeLocationServices() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied, we cannot request permissions.');
  }

  // If permissions are granted, continue with app initialization
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building MaterialApp");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>(create: (_) {
          print("Creating ProductViewModel");
          return ProductViewModel();
        }),
        ChangeNotifierProvider<CropsViewModel>(create: (_) {
          print("Creating ProductViewModel");
          return CropsViewModel();
        }),
        ChangeNotifierProvider<LanguageViewModel>(create: (_) => LanguageViewModel()),
        ChangeNotifierProvider<WeatherViewModel>(create: (_) => WeatherViewModel()),  // Provide the WeatherViewModel
        ChangeNotifierProvider<ProblemsViewModel>(create: (_) => ProblemsViewModel()),  // Provide the WeatherViewModel
      ],
      child: Consumer<LanguageViewModel>(
        builder: (context, languageViewModel, child) {
          return MaterialApp(
            title: 'Haryali Markaz',
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            locale: Locale(languageViewModel.selectedLanguage),
            supportedLocales: [
              Locale('en', ''), // English
              Locale('ur', ''), // Urdu
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: LanguageSelectionView(),
          );
        },
      ),
    );
  }
}
