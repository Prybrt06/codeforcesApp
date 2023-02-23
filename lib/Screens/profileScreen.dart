import 'package:codeforces_help/provider/userProvider.dart';
import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:codeforces_help/widget/userInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).getInfo(
          userName: StorageHandler().getUserName(),
        ),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                UserInfoWidget(user: snapshot.data),
              ],
            );
          } else {
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
