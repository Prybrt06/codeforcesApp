import 'dart:convert';

import 'package:codeforces_help/Model/contestModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListProvider with ChangeNotifier {
  var apiUrl = "https://codeforces.com/api/contest.list?gym=false";

  Future<List<ContestModel>> getContests() async {
    var res = await http.get(Uri.parse(apiUrl));

    var jsonResponse = await jsonDecode(res.body);

    int len = jsonResponse["result"].length;

    // print(jsonEncode(jsonResponse));

    List<ContestModel> contests = [];

    for (int i = 0; i < len; i++) {
      ContestModel contest = ContestModel(
        id: jsonResponse["result"][i]["id"].toString(),
        name: jsonResponse["result"][i]["name"],
        durationSeconds:
            (jsonResponse["result"][i]["durationSeconds"] / 3600).toInt(),
        startTimeSeconds:
            (jsonResponse["result"][i]["startTimeSeconds"]).toInt(),
      );

      contests.add(contest);
    }

    return contests;
  }
}
