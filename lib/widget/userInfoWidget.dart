import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/userModel.dart';
import '../Screens/RatingHistoryScreen.dart';

class UserInfoWidget extends StatelessWidget {
  final UserModel user;
  const UserInfoWidget({required this.user});

  Widget info(String query, String ans, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$query : ",
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          const Spacer(),
          Text(
            ans,
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ClipRRect(
                  child: Image.network(user.avatar),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Center(
                child: Text(
                  user.handle,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                  color: Theme.of(context).backgroundColor.withOpacity(0.25),
                ),
              ],
            ),
            child: Column(
              children: [
                info("Rating", user.rating.toString(), context),
                const Divider(
                  color: Colors.grey,
                ),
                info("Rank", user.rank, context),
                const Divider(
                  color: Colors.grey,
                ),
                info("Max Rank", user.maxRank, context),
                const Divider(
                  color: Colors.grey,
                ),
                info("Max Rating", user.maxRating.toString(), context),
                const Divider(
                  color: Colors.grey,
                ),
                info(
                    "Last Online",
                    DateFormat.yMEd().add_jms().format(
                          DateTime.fromMillisecondsSinceEpoch(
                            user.lastOnlineTimeSeconds * 1000,
                          ),
                        ),
                    context),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingHistoryScreen(
                    userName: user.handle,
                    userAvailable: false,
                  ),
                ),
              );
            },
            child: Text(
              "See rating history",
              style: TextStyle(
                color: StorageHandler().isDarkTheme()
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
