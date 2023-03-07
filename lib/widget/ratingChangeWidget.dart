import 'package:flutter/material.dart';

import '../Model/ratingChangeModel.dart';

class RatingChangeWidget extends StatelessWidget {
  final RatingChangeModel ratingChange;
  const RatingChangeWidget({required this.ratingChange});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: (ratingChange.newRating > ratingChange.oldRating)
                  ? Colors.green
                  : Colors.red,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Text(
              ratingChange.rank.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).backgroundColor.withOpacity(0.25),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ratingChange.contestName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text(
                        ratingChange.oldRating.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "${(ratingChange.newRating >= ratingChange.oldRating) ? '+' : ''}${ratingChange.newRating - ratingChange.oldRating}",
                        style: TextStyle(
                          color:
                              Theme.of(context).backgroundColor.withOpacity(0.5),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ratingChange.newRating.toString(),
                        style: TextStyle(
                            color:
                                (ratingChange.newRating >= ratingChange.oldRating)
                                    ? Colors.green
                                    : Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
