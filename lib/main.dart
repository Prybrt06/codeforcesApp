import 'package:codeforces_help/Screens/signInScreen.dart';
import 'package:codeforces_help/provider/listProvider.dart';
import 'package:codeforces_help/provider/userProvider.dart';
import 'package:codeforces_help/theme/brithness/dark.dart';
import 'package:codeforces_help/theme/brithness/light.dart';
import 'package:codeforces_help/theme/theme_handler.dart';
import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
        home: const Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Future.delayed(const Duration(milliseconds: 5000)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: Lottie.asset('assets/json/firstLoading.json'),
        ),
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
      return const MenuScreen();
    }
  }
}
