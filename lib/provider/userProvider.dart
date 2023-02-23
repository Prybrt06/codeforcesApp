import 'dart:convert';

import 'package:codeforces_help/Model/ratingChangeModel.dart';
import 'package:codeforces_help/Model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  var apiUrl = "https://codeforces.com/api/user.info?handles=";
  var ratingChangeApiUrl = "https://codeforces.com/api/user.rating?handle=";

  Future<UserModel> getInfo({required String userName}) async {
    var res = await http.get(Uri.parse("$apiUrl$userName"));
    var jsonResponse = await jsonDecode(res.body);

    UserModel user = UserModel(
      lastOnlineTimeSeconds:
          jsonResponse["result"][0]["lastOnlineTimeSeconds"].toInt(),
      rating: jsonResponse["result"][0]["rating"].toInt(),
      handle: jsonResponse["result"][0]["handle"],
      maxRank: jsonResponse["result"][0]["maxRank"],
      maxRating: jsonResponse["result"][0]["maxRating"].toInt(),
      rank: jsonResponse["result"][0]["rank"],
      avatar: jsonResponse["result"][0]["avatar"],
    );

    return user;
  }

  Future<List<RatingChangeModel>> getRatingChanges(
      {required String userName}) async {
    var res = await http.get(Uri.parse("$ratingChangeApiUrl$userName"));
    var jsonResponse = await jsonDecode(res.body);

    int len = jsonResponse["result"].length;

    List<RatingChangeModel> ratingChanges = [];

    for (int i = 0; i < len; i++) {
      RatingChangeModel ratingChange = RatingChangeModel(
        contestName: jsonResponse["result"][i]["contestName"],
        rank: jsonResponse["result"][i]["rank"],
        oldRating: jsonResponse["result"][i]["oldRating"],
        newRating: jsonResponse["result"][i]["newRating"],
      );

      ratingChanges.add(ratingChange);
    }

    return ratingChanges;
  }
}
