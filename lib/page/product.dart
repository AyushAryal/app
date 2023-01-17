import 'package:app/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:app/api/models.dart';

class ProductDetails extends StatelessWidget {
  final Item product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              "https://img.freepik.com/premium-vector/garlic-vector-hand-drawn-head-garlic-isolated-background_148553-133.jpg"),
          const SizedBox(height: 20),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 92, 91, 91),
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Rs. ${product.rate}",
                        style: TextStyle(
                          color: Colors.accents.last,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(product.description),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child:
                            const Icon(Icons.shopping_cart_checkout_outlined),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final Item product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ProductDetails(product: product),
    );
  }
}
