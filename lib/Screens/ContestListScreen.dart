import 'package:codeforces_help/Model/contestModel.dart';
import 'package:codeforces_help/provider/listProvider.dart';
import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:codeforces_help/widget/contestWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ContestListScreen extends StatefulWidget {
  const ContestListScreen({super.key});

  @override
  State<ContestListScreen> createState() => _ContestListScreenState();
}

class _ContestListScreenState extends State<ContestListScreen> {
  List<String> itemList = ["Today", "This Week", "All", "Upcoming", "Past"];
  String dropDownValue = "Today";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text("Contest List"),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: (StorageHandler().isDarkTheme())
                  ? Colors.grey.withOpacity(0.25)
                  : Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.only(right: 15),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                // style: TextStyle(backgroundColor: Colors.white),
                // focusColor: Colors.white,
                // iconEnabledColor: Colors.white,
                // dropdownColor: Colors.white,
                // iconDisabledColor: Colors.white,
                value: dropDownValue,
                icon: const Icon(Icons.filter_alt),
                items: itemList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                    // print(dropDownValue);
                    // currentChildId = getChildId(value);
                    // StorageHandler().setChildId(currentChildId);
                  });
                },
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: Provider.of<ListProvider>(context, listen: false)
                  .getContests(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<ContestModel> allContests = snapshot.data;
                  List<ContestModel> selectedList = [];
                  if (dropDownValue == "Today") {
                    selectedList = allContests
                        .where((element) => DateTime.fromMillisecondsSinceEpoch(
                                element.startTimeSeconds * 1000)
                            .isAfter(DateTime.now()))
                        .toList();
                    selectedList = selectedList
                        .where((element) => DateTime.fromMillisecondsSinceEpoch(
                                element.startTimeSeconds * 1000)
                            .isBefore(DateTime.now().add(Duration(days: 1))))
                        .toList();
                  } else if (dropDownValue == "This Week") {
                    selectedList = allContests
                        .where((element) => DateTime.fromMillisecondsSinceEpoch(
                                element.startTimeSeconds * 1000)
                            .isAfter(DateTime.now()))
                        .toList();
                    selectedList = selectedList
                        .where((element) => DateTime.fromMillisecondsSinceEpoch(
                                element.startTimeSeconds * 1000)
                            .isBefore(DateTime.now().add(Duration(days: 7))))
                        .toList();
                  } else if (dropDownValue == "All") {
                    selectedList = allContests;
                  } else if (dropDownValue == "Upcoming") {
                    selectedList = allContests
                        .where((e) => DateTime.fromMillisecondsSinceEpoch(
                                e.startTimeSeconds * 1000)
                            .isAfter(DateTime.now()))
                        .toList();
                  } else if (dropDownValue == "Past") {
                    selectedList = allContests
                        .where((element) => DateTime.fromMillisecondsSinceEpoch(
                                element.startTimeSeconds * 1000)
                            .isBefore(DateTime.now()))
                        .toList();
                  }

                  if (selectedList.isEmpty) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset('assets/json/empty.json'),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$dropDownValue there is no contest',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView(
                        children: selectedList
                            .map((e) => ContestWidget(contest: e))
                            .toList());
                  }
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
