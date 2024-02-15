import 'dart:convert';

import 'package:flatmates/const/constant.dart';
import 'package:flatmates/models/flat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FlatProvider extends ChangeNotifier {
  List<Flat> flatList = [];
  List<Flat> favflatList = [];
  bool _flatListFetched = false;
  bool _favFlatListFetched = false;

  List<Flat> ownFlatList = [];
  bool _ownFlatListFetched = false;

  int flatPage = 0;
  int flatPageLimit = 2;
  int favFlatPage = 0;
  int favFlatPageLimit = 2;

  get flatListFetched {
    return _flatListFetched;
  }

  get ownFlatListFetched {
    return _ownFlatListFetched;
  }

  get favFlatListFetched {
    return _favFlatListFetched;
  }

  Future<void> fetchAllFlats(bool refresh, String filter) async {
    try {
      if (refresh) {
        flatList = [];
        notifyListeners();
      }
      print("fetching started");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var url = "$server/flat/fetch-flat";
      if (filter.isNotEmpty) {
        url += filter;
      }
      print(url);
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        return;
      }
      String id =
          preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": accessToken, "userId": id},
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Flat> temp = [];
        for (var element in data['data']) {
          Flat flat = Flat.fromJson(element);
          temp.add(flat);
        }
        flatList.addAll(temp);
        _flatListFetched = true;
        flatPage = flatPage + 1;
        notifyListeners();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return;
    }
  }

  Future<void> fetchAllFavFlats(bool refresh) async {
    try {
      if (refresh) {
        favflatList = [];
        notifyListeners();
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      const url = "$server/flat/fetch-favourite-flat";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        return;
      }
      String id =
          preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": accessToken, "userId": id},
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Flat> temp = [];
        for (var element in data['data']) {
          Flat flat = Flat.fromJson(element);
          temp.add(flat);
        }
        favflatList = temp;
        _favFlatListFetched = true;
        notifyListeners();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return;
    }
  }

  Future<void> fetchAllOwnFlats(bool refresh) async {
    try {
      if (refresh) {
        ownFlatList = [];
        notifyListeners();
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      const url = "$server/flat/fetch-own-flat";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        return;
      }
      String id =
          preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": accessToken, "userId": id},
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Flat> temp = [];
        for (var element in data['data']) {
          Flat flat = Flat.fromJson(element);
          temp.add(flat);
        }
        ownFlatList = temp;
        _ownFlatListFetched = true;
        notifyListeners();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong while loading data $e");
      return;
    }
  }

  Future<bool> addFlatToFavourite(String flatId) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final url = "$server/flat/add-flat-to-favourite";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        return false;
      }
      String id =
          preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.post(Uri.parse(url), headers: {
        "Authorization": accessToken,
      }, body: {
        "userId": id,
        "flatId": flatId
      });
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = data['data'];

        Flat flat = Flat.fromJson(responseData);

        favflatList.add(flat);
        notifyListeners();
        return true;
      } else {
        print("Something went wrong");
        return false;
      }
    } catch (e) {
      print("Error adding item to favourite: $e");
      return false;
    }
  }

  Future<bool> removeFlatToFavourite(String flatId) async {
    try {
      print(flatId);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final url = "$server/flat/remove-flat-from-favourite";
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? accessToken = await pref.getString("accessToken");
      if (accessToken == null) {
        return false;
      }
      String id =
          preferences.getString("userId").toString().replaceAll('"', '');
      final response = await http.post(Uri.parse(url), headers: {
        "Authorization": accessToken,
      }, body: {
        "userId": id,
        "flatId": flatId
      });

      if (response.statusCode == 200) {
        favflatList.removeWhere((element) => element.id == flatId);
        Flat? foundElement =
            flatList.firstWhere((element) => element.id == flatId);
        // ignore: unnecessary_null_comparison
        if (foundElement != null) {
          foundElement.favourite = false;
        }

        notifyListeners();
        return true;
      } else {
        print("Something went wrong");
        return false;
      }
    } catch (e) {
      print("Something went wrong while adding item to favourite");
      return false;
    }
  }
}
