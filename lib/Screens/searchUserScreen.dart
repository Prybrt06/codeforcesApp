import 'package:codeforces_help/Model/userModel.dart';
import 'package:codeforces_help/Screens/RatingHistoryScreen.dart';
import 'package:codeforces_help/provider/userProvider.dart';
import 'package:codeforces_help/widget/userInfoWidget.dart';
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
        backgroundColor: Theme.of(context).primaryColor,

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
                  : UserInfoWidget(user: user!)
            ],
          ),
        ),
      ),
    );
  }
}