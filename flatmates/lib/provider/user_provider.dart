import 'dart:convert';

import 'package:flatmates/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool isloading = false;

  Future<bool> sendOTPUser(String number) async {
    try {
      isloading = true;
      notifyListeners();

      const url = "$server/user/send-otp";
      final response = await http.post(
        Uri.parse(url),
        body: {'phoneNumber': number},
      );

      isloading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      isloading = false;
      notifyListeners();
      print("$e");
      return false;
    }
  }

  Future<bool> verifyOTPUser(String number, String otp) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      isloading = true;
      notifyListeners();

      const url = "$server/user/verify-otp";
      final response = await http.post(
        Uri.parse(url),
        body: {'phoneNumber': number, 'otp': otp},
      );

      isloading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        bool result = await pref.setString("userName", data['data']['user']['name']);
        if (!result) {
          print("Something wrong while storing user in the local Device");
          return false;
        }

        result = await pref.setString("phoneNumber", data['data']['user']['phoneNumber']);
        if (!result) {
          print("Something wrong while storing phone number in the local Device");
          return false;
        }

        result = await pref.setString("accessToken", data['data']['AccessToken'].toString().replaceAll('"', ''));
        if (!result) {
          print("Something wrong while storing accessToken in the local Device");
          return false;
        }

        result = await pref.setString("userId", data['data']['user']['_id'].toString().replaceAll('"', ''));
        if (!result) {
          print("Something wrong while storing userId in the local Device");
          return false;
        }

        print(data);
        return true;
      }

      return false;
    } catch (e) {
      isloading = false;
      notifyListeners();
      print("$e");
      return false;
    }
  }

  Future<bool> verifyUserToken(String accessToken) async {
    try {
      const url = "$server/user/access-token-verify";
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": accessToken,
          "Content-Type": "application/json",
        },
      );

      final data = response.body;
      print(data);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      isloading = false;
      notifyListeners();
      print("Something went wrong while checking access token. Error: $e");
      return false;
    }
  }

  Future<bool> updateUser(String name) async {
    try {
      isloading = true;
      notifyListeners();

      SharedPreferences preferences = await SharedPreferences.getInstance();
      const url = "$server/user/update";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        isloading = false;
        notifyListeners();
        return false;
      }
      String id = preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": accessToken},
        body: {"userId": id, "name": name},
      );

      isloading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Something went wrong");
        return false;
      }
    } catch (e) {
      isloading = false;
      notifyListeners();
      print("Something went wrong while loading data $e");
      return false;
    }
  }
}
