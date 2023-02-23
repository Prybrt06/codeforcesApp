import 'package:codeforces_help/Screens/menuScreen.dart';
import 'package:codeforces_help/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String errorText = "";
  bool isErrorVisible = false;

  @override
  Widget build(BuildContext context) {
    void unFocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    TextEditingController cfUserNameController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  TextFormField(
                    controller: cfUserNameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Codeforces username",
                      errorText: (isErrorVisible) ? errorText : null,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      unFocus();
                      setState(() {
                        isErrorVisible = false;
                      });
                      var res = await http.get(
                        Uri.parse(
                          "https://codeforces.com/api/user.info?handles=${cfUserNameController.text}",
                        ),
                      );

                      if (res.statusCode == 200) {
                        isErrorVisible = false;
                        StorageHandler().setUserName(cfUserNameController.text);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MenuScreen(),
                          ),
                        );
                      } else {
                        setState(() {
                          isErrorVisible = true;
                          errorText = "Enter a valid UserName";
                        });
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MenuScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Skip >",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
