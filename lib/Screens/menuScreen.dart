import 'package:codeforces_help/Screens/searchUserScreen.dart';
import 'package:flutter/material.dart';

import 'ContestListScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Codeforces Help",
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContestListScreen(),
                    ),
                  ),
                  child: const Text("Contest List"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchUserScreen(),
                    ),
                  ),
                  child: const Text("Search User"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContestListScreen(),
                    ),
                  ),
                  child: const Text("Contest List"),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SearchUserScreen(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
