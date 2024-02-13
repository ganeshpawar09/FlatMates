import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/chat/chat_page.dart';
import 'package:flatmates/pages/home/home_page.dart';
import 'package:flatmates/pages/profile/profile_page.dart';
import 'package:flatmates/pages/shorlist_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({super.key});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  int _currIndex = 0;
  String? userId;
  final _pages = [HomePage(), ShortListPage(), ChatPage(), ProfilePage()];
  void socketInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = await sharedPreferences.getString("userId");
  }

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: customWhite,
          elevation: 0,
          selectedLabelStyle: AppStyles.mondaB.copyWith(fontSize: 12),
          selectedItemColor: customYellow,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              _currIndex = value;
            });
          },
          currentIndex: _currIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.home_alt),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.heart),
              label: "Shortlisted",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.chat),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.user),
              label: "Profile",
            ),
          ],
        ));
  }
}
