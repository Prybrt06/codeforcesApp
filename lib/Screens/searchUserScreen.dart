import 'package:codeforces_help/Model/userModel.dart';
import 'package:codeforces_help/Screens/RatingHistoryScreen.dart';
import 'package:codeforces_help/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  UserModel? user;

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search User"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: userName,
                decoration: const InputDecoration(hintText: "UserName"),
              ),
              Center(
                child: ElevatedButton(
                  child: Text("Search"),
                  onPressed: () async {
                    unFocus();
                    user =
                        await Provider.of<UserProvider>(context, listen: false)
                            .getInfo(userName: userName.text);
                    setState(() {
                      userName.text = "";
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              (user == null)
                  ? const SizedBox(
                      height: 10,
                    )
                  : UserInfo(user: user!)
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final UserModel user;
  const UserInfo({required this.user});

  Widget info(String query, String ans) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$query : "),
          const Spacer(),
          Text(ans),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Column(
              children: [
                info("Rating", user.rating.toString()),
                const Divider(
                  color: Colors.grey,
                ),
                info("Rank", user.rank),
                const Divider(
                  color: Colors.grey,
                ),
                info("Max Rank", user.maxRank),
                const Divider(
                  color: Colors.grey,
                ),
                info("Max Rating", user.maxRating.toString()),
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
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
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
            child: const Text(
              "See rating history",
            ),
          ),
        ],
      ),
    );
  }
}
