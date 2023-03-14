import 'package:flutter/material.dart';

import 'package:app/widgets/scaffold.dart';
import 'package:app/widgets/item_listings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: ListView(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              "assets/1.jpg",
              bundle: DefaultAssetBundle.of(context),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome to FARMERZ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Eat on a budget",
                    style: TextStyle(
                      fontSize: 25,
                      color: HSLColor.fromAHSL(
                              1, animationController.value * 360, 1, 0.9)
                          .toColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const ItemListings(),
      ],
    ));
  }
}
