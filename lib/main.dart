import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'viewmodels/product_viewmodel.dart';
import 'views/product_list_view.dart';
import 'models/product.dart';
import 'models/category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure this line is present

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CategoryAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building MaterialApp");  // Print when MaterialApp is being built
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>(create: (_) {
          print("Creating ProductViewModel");  // Print when ViewModel is created
          return ProductViewModel();
        }),
      ],
      child: MaterialApp(
        title: 'Haryali Markaz',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductListView(),
      ),
    );
  }
}
