import 'package:codeforces_help/Model/contestModel.dart';
import 'package:codeforces_help/provider/listProvider.dart';
import 'package:codeforces_help/widget/contestWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContestListScreen extends StatefulWidget {
  const ContestListScreen({super.key});

  @override
  State<ContestListScreen> createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contest List"),
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: Provider.of<ListProvider>(context, listen: false)
                  .getContests(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<ContestModel> contests = snapshot.data;
                  return ListView(
                      children: contests
                          .map((e) => ContestWidget(contest: e))
                          .toList());
                } else {
                  return const Center(
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
