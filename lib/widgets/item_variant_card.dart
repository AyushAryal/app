import 'package:flutter/material.dart';
import 'package:app/api/models/item_variant.dart';

class ItemVariantCard extends StatelessWidget {
  final ItemVariant variant;
  const ItemVariantCard({required this.variant, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        variant.images.isNotEmpty
            ? Image.network(
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
                variant.images.first.toString(),
              )
            : Image.asset(
                "assets/image_not_found.png",
                bundle: DefaultAssetBundle.of(context),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
        Container(
          decoration: BoxDecoration(color: Colors.black.withAlpha(150)),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    variant.color,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Icon(Icons.shopping_cart_checkout_outlined),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rs. ${variant.rate}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  variant.stock > 0
                      ? Text(
                          "${variant.stock} IN STOCK",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade200,
                          ),
                        )
                      : Text(
                          "OUT OF STOCK",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red.shade200,
                          ),
                        ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
