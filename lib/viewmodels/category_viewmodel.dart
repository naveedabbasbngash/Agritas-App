import 'package:agritas_app/models/product.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/product_api.dart';
import '../utils/local_storage.dart';

class CategoryViewModel extends ChangeNotifier {
  List<Product> _categories = [];
  bool _isLoading = false;

  List<Product> get categories => _categories;
  bool get isLoading => _isLoading;

}
