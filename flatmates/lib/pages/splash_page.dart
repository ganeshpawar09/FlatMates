import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/login/request_otp_page.dart';
import 'package:flatmates/provider/user_provider.dart';
import 'package:flatmates/widget/customBottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? accessToken = await pref.getString("accessToken");
        if (accessToken == null || accessToken.isEmpty) {
          print("New User");
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RequestOTPPage(),
            ),
          );
        } else {
          print(accessToken);
          bool correctAccessToken =
              await Provider.of<UserProvider>(context, listen: false)
                  .verifyUserToken(accessToken);

          if (correctAccessToken) {
            print("User has access token yet");
            return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CustomBottomNavigator(),
              ),
            );
          } else {
            print("User has no access token yet");
            // Print more information about the error or response from the server
            // to help identify the issue.
            print("Error during token verification");
            return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RequestOTPPage(),
              ),
            );
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: customWhite, elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Flat",
                style: TextStyle(
                    fontSize: 45,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "Mates",
                style: AppStyles.mondaB.copyWith(
                  fontSize: 45,
                  color: customYellow,
                ),
              )
            ])),
            Text(
              "Find A Perfect FlatMate",
              style: AppStyles.mondaB.copyWith(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
