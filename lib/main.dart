import 'package:flutter/material.dart';
import 'package:product_listing/screens/home.dart';

void main() {
  runApp(const ProductListingActivity());
}

class ProductListingActivity extends StatelessWidget {
  const ProductListingActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen()
    );
  }
}