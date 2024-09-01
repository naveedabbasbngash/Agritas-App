import 'package:agritas_app/viewmodels/weather_viewmodel.dart';
import 'package:agritas_app/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:provider/provider.dart';

void main() {
  testWidgets('DashboardView displays correct UI elements', (WidgetTester tester) async {
    // Create a mock WeatherViewModel
    final weatherViewModel = WeatherViewModel();

    // Pump the DashboardView widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<WeatherViewModel>(
          create: (_) => weatherViewModel,
          child: DashboardView(),
        ),
      ),
    );

    // Verify that the loading texts are displayed initially
    expect(find.text('Loading...'), findsNWidgets(2));

    // You can also verify specific widgets, like the logo, grid items, etc.
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Products'), findsOneWidget);
    expect(find.text('Crops'), findsOneWidget);

    // You can test specific interactions, like tapping a button
    // For example, verify tapping a grid item triggers navigation or action
  });

  testWidgets('DashboardView scrolls when content overflows', (WidgetTester tester) async {
    // Create a mock WeatherViewModel
    final weatherViewModel = WeatherViewModel();

    // Pump the DashboardView widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<WeatherViewModel>(
          create: (_) => weatherViewModel,
          child: DashboardView(),
        ),
      ),
    );

    // Verify the initial state before scrolling
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Scroll the view to ensure that it handles overflow properly
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Verify that after scrolling, more content is visible
    // For example, check if the last grid item is visible after scrolling
    expect(find.text('Services'), findsOneWidget);
  });
}
