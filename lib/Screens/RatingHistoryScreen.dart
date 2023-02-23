import 'package:codeforces_help/Model/ratingChangeModel.dart';
import 'package:codeforces_help/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/ratingChangeWidget.dart';

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
        backgroundColor: Theme.of(context).primaryColor,

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

