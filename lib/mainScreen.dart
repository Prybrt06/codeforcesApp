import 'package:codeforces_help/Model/contestModel.dart';
import 'package:codeforces_help/provider/listProvider.dart';
import 'package:codeforces_help/widget/contestWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future:
                  Provider.of<ListProvider>(context, listen: false).getContests(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<ContestModel> contests = snapshot.data;
                  return ListView(
                      children:
                          contests.map((e) => ContestWidget(contest: e)).toList());
                } else {
                  return Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
