import 'package:app/api/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/api/models/item.dart';
import 'package:app/api/services/item.dart';
import 'package:app/models.dart';

class RatingWidget extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final int itemId;

  const RatingWidget({
    required this.itemId,
    super.key,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class CombinedRatings {
  int user;
  double item;
  CombinedRatings({required this.user, required this.item});
}

class _RatingWidgetState extends State<RatingWidget> {
  late Future<CombinedRatings> ratingFuture;

  @override
  void initState() {
    final token =
        Provider.of<TokenProvider>(context, listen: false).getToken()!;
    final service = ItemService();

    ratingFuture = () async {
      final item = await service.get(token: token.token, id: widget.itemId);
      try {
        final userRating =
            await service.getUserRating(token: token.token, id: widget.itemId);
        return CombinedRatings(user: userRating, item: item.rating);
      } on KnownServerError {
        return CombinedRatings(user: 0, item: item.rating);
      }
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final token =
        Provider.of<TokenProvider>(context, listen: false).getToken()!;
    return FutureBuilder(
        future: ratingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            final rating = snapshot.data!;
            List<Widget> stars = [];
            for (int i = 0; i < 5; i++) {
              stars.add(
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () async {
                    final service = ItemService();
                    await service.setRating(token.token, widget.itemId,
                        i + 1 == rating.item ? 0 : i + 1);
                    final newData = await () async {
                      final item = await service.get(
                          token: token.token, id: widget.itemId);
                      try {
                        final userRating = await service.getUserRating(
                            token: token.token, id: widget.itemId);
                        return CombinedRatings(
                            user: userRating, item: item.rating);
                      } on KnownServerError {
                        return CombinedRatings(user: 0, item: item.rating);
                      }
                    }();
                    setState(() {
                      ratingFuture = Future.value(newData);
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: rating.user <= i
                        ? widget.inactiveColor
                        : widget.activeColor,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.stars, color: widget.activeColor),
                    const SizedBox(width: 5),
                    Text(
                      "${rating.item.toStringAsFixed(2)}/5",
                      style: TextStyle(color: widget.activeColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: stars,
                ),
              ],
            );
          } else {
            return SizedBox();
            // return const SizedBox(
            //   width: double.infinity,
            //   child: AspectRatio(
            //     aspectRatio: 1,
            //     child: CircularProgressIndicator(),
            //   ),
            // );
          }
        });
  }
}
