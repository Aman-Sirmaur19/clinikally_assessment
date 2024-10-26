import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      print("Loading CSV file...");
      final csvData = await rootBundle.loadString('assets/csv/Products.csv');
      print("CSV file loaded successfully.");

      final List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

      // Check each row content for debugging
      for (var row in csvTable) {
        print("Row data: $row");
      }

      setState(() {
        // Skip the header row explicitly if it's being counted
        products = csvTable
            .skip(1) // Skip header row
            .where((row) => row.length >= 3) // Ensure each row has at least 3 columns
            .map((csvRow) => Product.fromCsv(csvRow))
            .toList();
      });

      print("Products loaded: ${products.length}");
    } catch (e) {
      print("Error loading CSV: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Clinikally',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}
