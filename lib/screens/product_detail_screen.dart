import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers.dart';
import '../models/product.dart';
import 'home_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final bool isAvailable;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.isAvailable,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  final pinCodeDetails = Helpers.getPinCodeData(pinCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        title: const Text(
          'Clinikally',
          style: TextStyle(
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(pinCode.isEmpty ? 'PIN CODE' : 'PIN: $pinCode'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            Text(
              widget.product.name,
              style: const TextStyle(
                letterSpacing: 1,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Image slider
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: 5,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.shopping_bag_rounded,
                    size: 100,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Indicator for image slider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentImageIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'MRP: ',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '₹${widget.product.price}',
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 25,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border_rounded)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share_outlined)),
                      ],
                    ),
                  ],
                ),
                const Text(
                  '(incl. of all taxes.)',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.isAvailable == true ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        widget.isAvailable == true ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (pinCode.isNotEmpty)
              ListTile(
                title: Text(pinCodeDetails['Logistics Provider'] ??
                    "Provider Not Available"),
                subtitle: Text("TAT: ${pinCodeDetails['TAT'] ?? "N/A"}"),
                trailing:
                    Text("Pincode: ${pinCodeDetails['Pincode'] ?? ""}"),
              )
          ],
        ),
      ),
    );
  }
}
