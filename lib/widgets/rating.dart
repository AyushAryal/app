import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final Color activeColor;
  final Color inactiveColor;
  const RatingWidget({
    required this.rating,
    super.key,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(
        Icon(Icons.star, color: rating <= i ? inactiveColor : activeColor),
      );
    }
    return Row(children: stars);
  }
}
