import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/login/verify_otp_page.dart';
import 'package:flatmates/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestOTPPage extends StatefulWidget {
  const RequestOTPPage({super.key});

  @override
  State<RequestOTPPage> createState() => _RequestOTPPageState();
}

class _RequestOTPPageState extends State<RequestOTPPage> {
  final TextEditingController _mobileNumber = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  void requestOTP(String number) async {
    if (number.length != 10) {
      final snackBar = SnackBar(
        content: const Text('Invalid Mobile Number'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    bool send = await Provider.of<UserProvider>(context, listen: false)
        .sendOTPUser("+91$number");

    if (send) {
      print("hello");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyOTPPage( number: "+91$number"),
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
    _mobileNumber.dispose();
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
            "assets/images/send.png",
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Verify Mobile Number",
            style: AppStyles.mondaB.copyWith(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "We will send you OTP on the mobile number",
              textAlign: TextAlign.center,
              style:
                  AppStyles.mondaN.copyWith(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Row(
                children: [
                  Text(
                    " +91   ",
                    style: AppStyles.mondaB.copyWith(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      controller: _mobileNumber,
                      cursorColor: Colors.black,
                      style: AppStyles.mondaB.copyWith(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                      decoration: InputDecoration(
                          hintText: "0000000000",
                          hintStyle: AppStyles.mondaB.copyWith(
                              color: Colors.black45,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero),
                    ),
                  ),
                ],
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
              _focusNode.unfocus();

              requestOTP(_mobileNumber.text);
            },
            child: Text(
              "Request OTP",
              style: AppStyles.mondaB.copyWith(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
