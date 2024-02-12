import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/chat/chat_page.dart';
import 'package:flatmates/pages/home_page.dart';
import 'package:flatmates/pages/profile/profile_page.dart';
import 'package:flatmates/pages/shorlist_page.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({super.key});

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  int _currIndex = 0;
  final _pages = [HomePage(), ShortListPage(), ChatPage(), ProfilePage()];
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
