import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/home/home_page.dart';
import 'package:flatmates/pages/login/request_otp_page.dart';
import 'package:flatmates/provider/user_provider.dart';
import 'package:flatmates/widget/customBottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyOTPPage extends StatefulWidget {
  final String number;
  const VerifyOTPPage({super.key, required this.number});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final TextEditingController _otp = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  void resendOTP() async {
    bool resend = await Provider.of<UserProvider>(context, listen: false)
        .sendOTPUser(widget.number);

    if (resend) {
      print("hello");
      final snackBar = SnackBar(
        content: const Text('OTP send successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: const Text('Something went wrong Try Again'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void verifyOTP() async {
    String otp = _otp.text;
    if (otp.length != 6) {
      final snackBar = SnackBar(
        content: const Text('Invalid OTP'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    bool isCorrect = await Provider.of<UserProvider>(context, listen: false)
        .verifyOTPUser(widget.number, otp);

    if (isCorrect) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomBottomNavigator(),
        ),
      );
    } else {
      final snackBar = SnackBar(
        content: const Text('Something went wrong Try Again'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          Image.asset(
            "assets/images/otp.png",
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "OTP Verifiacation",
            style: AppStyles.mondaB.copyWith(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestOTPPage(),
                  ),
                );
              },
              splashColor: Colors.black,
              child: Text.rich(
                TextSpan(
                  text: "Please enter the OTP sent to ",
                  style: AppStyles.mondaN
                      .copyWith(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${widget.number} ",
                      style: AppStyles.mondaB
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "change",
                      style: AppStyles.mondaB.copyWith(
                          fontWeight: FontWeight.bold, color: customYellow),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
              bottom: 10,
            ),
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                focusNode: FocusNode(),
                controller: _otp,
                cursorColor: Colors.black54,
                style: AppStyles.mondaB.copyWith(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "000000",
                  hintStyle: AppStyles.mondaB.copyWith(
                    color: Colors.black54,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: customYellow,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minimumSize: const Size(200, 40)),
            onPressed: () {
              return verifyOTP();
            },
            child: Text(
              "Verify",
              style: AppStyles.mondaB.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              resendOTP();
            },
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: " Not received your code?",
                style: AppStyles.mondaB.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: " Resend Code",
                style: AppStyles.mondaB.copyWith(
                    color: customYellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ])),
          ),
        ]),
      ),
    );
  }
}
