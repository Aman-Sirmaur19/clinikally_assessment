import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

String pinCode = '';
List<Product> products = [];
Map<String, bool> stockAvailability = {};
List<Map<String, dynamic>> pinCodeData = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    try {
      await Helpers.loadProducts();
      await Helpers.loadStockData();
      await Helpers.loadPinCodeData();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error loading data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          'Clinikally',
          style: TextStyle(
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
              onPressed: _getPincodeFromUser,
              child: Text(pinCode.isEmpty ? 'PIN CODE' : 'PIN: $pinCode'))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => ProductDetailScreen(
                                  product: product,
                                  isAvailable: stockAvailability[product.id]!,
                                ))),
                    child: ProductCard(product: product));
              },
            ),
    );
  }

  // Show dialog to get pincode from user
  Future<void> _getPincodeFromUser() async {
    final pincodeController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enter Pincode"),
        content: TextField(
          controller: pincodeController,
          decoration: const InputDecoration(
            hintText: "Enter pincode",
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (pincodeController.text.trim().length == 6) {
                setState(() {
                  pinCode = pincodeController.text;
                });
                Navigator.of(context).pop();
              } else {
                return;
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}

// Future<void> loadProducts() async {
//   try {
//     print("Loading CSV file...");
//     final csvData = await rootBundle.loadString('assets/csv/Products.csv');
//     print("CSV file loaded successfully.");
//
//     final List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);
//
//     // Check each row content for debugging
//     for (var row in csvTable) {
//       print("Row data: $row");
//     }
//
//     setState(() {
//       // Skip the header row explicitly if it's being counted
//       products = csvTable
//           .skip(1) // Skip header row
//           .where((row) => row.length >= 3) // Ensure each row has at least 3 columns
//           .map((csvRow) => Product.fromCsv(csvRow))
//           .toList();
//     });
//
//     print("Products loaded: ${products.length}");
//   } catch (e) {
//     print("Error loading CSV: $e");
//   }
// }
