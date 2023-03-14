import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/api/models/token.dart';
import 'package:app/api/models/cart.dart';
import 'package:app/api/models/cart_item.dart';
import 'package:app/api/services/cart.dart';
import 'package:app/models.dart';
import 'package:app/widgets/scaffold.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<Cart> cartFuture;

  @override
  void initState() {
    final service = CartService();
    final token = Provider.of<TokenProvider>(context, listen: false).getToken();
    if (token != null) {
      cartFuture = service.get(token.token);
    } else {
      cartFuture = Future.error("");
    }
    super.initState();
  }

  Widget drawCart(
      BuildContext context, Token token, CartService service, Cart cart) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Text(
            cart.items.isNotEmpty ? "Your cart" : "Your cart is empty",
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 10.0),
          ...cart.items.map((x) => drawCartItem(context, token, service, x)),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cart.items.isNotEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cartFuture = service.checkout(token.token);
                        });
                      },
                      child: const Text("Checkout"))
                  : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }

  Widget drawCartItem(BuildContext context, Token token, CartService service,
      CartItem cartItem) {
    final variant = cartItem.item.getVariant(cartItem.itemVariant)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // height: 70,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          variant.images.isNotEmpty
              ? Image.network(
                  variant.images.first.toString(),
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/image_not_found.png",
                  bundle: DefaultAssetBundle.of(context),
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover,
                ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                variant.color.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          cartFuture = service.incrementItemVariant(
                              token.token, variant.id,
                              value: -1);
                        });
                      },
                      icon: const Icon(Icons.remove)),
                  Text(cartItem.quantity.toString()),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          cartFuture = service.incrementItemVariant(
                              token.token, variant.id);
                        });
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          cartFuture = service.deleteItemVariant(
                              token.token, variant.id);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final token =
        Provider.of<TokenProvider>(context, listen: false).getToken()!;
    final service = CartService();

    return CustomScaffold(
      body: FutureBuilder(
        future: cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            final cart = snapshot.data!;
            return drawCart(context, token, service, cart);
          } else {
            return const SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
