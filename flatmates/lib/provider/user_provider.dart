import 'dart:convert';

import 'package:flatmates/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Future<bool> sendOTPUser(String number) async {
    try {
      final url = "$server/user/send-otp";
      final response = await http.post(
        Uri.parse(url),
        body: {
          'phoneNumber': number,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      ;
      return false;
    } catch (e) {
      print("$e");
      return false;
    }
  }

  Future<bool> verifyOTPUser(String number, String otp) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final url = "$server/user/verify-otp";
      final response = await http.post(
        Uri.parse(url),
        body: {
          'phoneNumber': number,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        bool result =
            await pref.setString("userName", data['data']['user']['name']);
        if (!result) {
          print("Something wrong while storing user in the local Device");
          return false;
        }

        result = await pref.setString("accessToken",
            data['data']['AccessToken'].toString().replaceAll('"', ''));
        if (!result) {
          print(
              "Something wrong while storing accessToken in the local Device");
          return false;
        }

        result = await pref.setString("userId",
            data['data']['user']['_id'].toString().replaceAll('"', ''));
        if (!result) {
          print("Something wrong while storing userId in the local Device");
          return false;
        }
        print(data);
        return true;
      }
      return false;
    } catch (e) {
      print("$e");
      return false;
    }
  }

  Future<bool> verifyUserToken(String accessToken) async {
    try {
      final url = "$server/user/access-token-verify";
      final http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": accessToken,
        "Content-Type": "application/json",
      });

      final data = response.body;
      print(data);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      print("Something went wrong while checking access token. Error: $e");
      return false;
    }
  }
}
