import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  // Utility function to format currency from a double value
  static String formatCurrency(double amount) {
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return currencyFormatter.format(amount);

  }

  // Utility function to show a simple snackbar
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
