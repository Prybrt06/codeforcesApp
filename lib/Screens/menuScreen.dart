import 'package:codeforces_help/Screens/profileScreen.dart';
import 'package:codeforces_help/Screens/searchUserScreen.dart';
import 'package:codeforces_help/Screens/signInScreen.dart';
import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codeforces_help/theme/theme_handler.dart';
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
        leading: (StorageHandler().getUserName() == "")
            ? null
            : IconButton(
              color: Colors.white,
                icon: const Icon(
                  Icons.bar_chart_rounded,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
              ),
        title: const Text(
          "Codeforces Help",
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              StorageHandler().setUserName("");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 70,
              bottom: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: StorageHandler().isDarkTheme() ? Colors.white : Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  color: Theme.of(context).canvasColor,
                  icon: Icon(
                    (StorageHandler().isDarkTheme())
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () {
                    Provider.of<ThemeHandler>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: StorageHandler().isDarkTheme() ? Colors.white : Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  color: Theme.of(context).canvasColor,
                  icon: Icon(Icons.search),
                  onPressed: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchUserScreen(),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ContestListScreen(),
                        ),
                      ),
                      child: Text(
                        "Contest List",
                        style: TextStyle(
                          color: StorageHandler().isDarkTheme()
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchUserScreen(),
                        ),
                      ),
                      child: Text(
                        "Search User",
                        style: TextStyle(
                          color: StorageHandler().isDarkTheme()
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ContestListScreen(),
                        ),
                      ),
                      child: Text(
                        "Contest List",
                        style: TextStyle(
                          color: StorageHandler().isDarkTheme()
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Row(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.fromLTRB(300, 0, 8, 26),
      //       child: Builder(builder: (context) {
      //         return FloatingActionButton(
      //           onPressed: (() {
      //             Provider.of<ThemeHandler>(context, listen: false)
      //                 .toggleTheme();
      //           }),
      //         );
      //       }),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
      //       child: Builder(builder: (context) {
      //         return FloatingActionButton(
      //           onPressed: () {
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => const SearchUserScreen(),
      //               ),
      //             );
      //           },
      //           child: Icon(
      //             Icons.search,
      //             color: (StorageHandler().isDarkTheme())
      //                 ? Colors.white
      //                 : Colors.black,
      //           ),
      //         );
      //       }),
      //     ),
      //   ],
      // ),
    );
  }
}
