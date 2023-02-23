import 'package:codeforces_help/Screens/signInScreen.dart';
import 'package:codeforces_help/provider/listProvider.dart';
import 'package:codeforces_help/provider/userProvider.dart';
import 'package:codeforces_help/theme/brithness/dark.dart';
import 'package:codeforces_help/theme/brithness/light.dart';
import 'package:codeforces_help/theme/theme_handler.dart';
import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/menuScreen.dart';

late ThemeHandler _themeHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHandler().initPreferences();

  _themeHandler = ThemeHandler();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void themeListener() {
    if (mounted) {
      setState(() {
        StorageHandler().toggleDarkTheme();
      });
    }
  }

  @override
  void initState() {
    _themeHandler.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    _themeHandler.removeListener(themeListener);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              ThemeHandler(themeHandler: _themeHandler),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Codeforces help',
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: _themeHandler.themeMode,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (StorageHandler().getUserName() == "") {
      return SignInScreen();
    } else {
      return MenuScreen();
    }
  }
}
