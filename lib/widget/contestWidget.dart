import 'package:codeforces_help/Model/contestModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContestWidget extends StatefulWidget {
  ContestModel contest;
  ContestWidget({
    required this.contest,
  });

  @override
  State<ContestWidget> createState() => _ContestWidgetState();
}

class _ContestWidgetState extends State<ContestWidget> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        widget.contest.startTimeSeconds * 1000);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (date.isAfter(DateTime.now()))
            ? Colors.blue.shade400
            : Colors.blue.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.contest.name,
              style: TextStyle(
                color: (date.isAfter(DateTime.now()))
                    ? Colors.white
                    : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Duration : ",
                  style: TextStyle(
                    color: (date.isAfter(DateTime.now()))
                        ? Colors.grey.shade300
                        : Colors.blueGrey.shade900,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${widget.contest.durationSeconds} hours",
                  style: TextStyle(
                    color: (date.isAfter(DateTime.now()))
                        ? Colors.grey.shade300
                        : Colors.blueGrey.shade900,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Starts on : ",
                  style: TextStyle(
                    color: (date.isAfter(DateTime.now()))
                        ? Colors.grey.shade300
                        : Colors.blueGrey.shade900,
                    fontSize: 18,
                  ),
                ),
                Text(
                  DateFormat.yMEd().add_jms().format(date),
                  style: TextStyle(
                    color: (date.isAfter(DateTime.now()))
                        ? Colors.grey.shade300
                        : Colors.blueGrey.shade900,
                    fontSize: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
