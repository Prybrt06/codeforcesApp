import 'package:codeforces_help/Model/ratingChangeModel.dart';
import 'package:codeforces_help/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatingHistoryScreen extends StatelessWidget {
  final String userName;
  final bool userAvailable;
  const RatingHistoryScreen(
      {required this.userName, required this.userAvailable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rating Changes"),
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .getRatingChanges(userName: userName),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<RatingChangeModel> ratingChanges = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: ratingChanges
                    .map((e) => RatingChangeWidget(ratingChange: e))
                    .toList(),
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class RatingChangeWidget extends StatelessWidget {
  final RatingChangeModel ratingChange;
  const RatingChangeWidget({required this.ratingChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 4),
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
          const Divider(color: Colors.grey,),
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
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const Spacer(),
                Text(
                  ratingChange.newRating.toString(),
                  style: TextStyle(
                      color: (ratingChange.newRating >= ratingChange.oldRating)
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
    );
  }
}
