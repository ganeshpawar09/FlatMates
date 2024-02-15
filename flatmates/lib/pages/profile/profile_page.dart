import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/pages/home/home_page.dart';
import 'package:flatmates/pages/profile/own_flat_page.dart';
import 'package:flatmates/pages/profile/update_user_page.dart';
import 'package:flatmates/pages/profile/upload_new_request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName = "User100";
  String? phoneNumber = "";
  void getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userName = preferences.getString("userName");
    phoneNumber = preferences.getString("phoneNumber");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Profile",
          style: AppStyles.mondaB.copyWith(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/icons/boy_avatar.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$userName",
                style: AppStyles.mondaB,
              ),
              const SizedBox(
                height: 20,
              ),
              customCard(
                  context,
                  UpdateUserPage(
                    userName: userName ?? "",
                    phoneNumber: phoneNumber ?? "",
                  ),
                  UniconsLine.edit_alt,
                  "Edit Profile"),
              customCard(context, UploadNewRequest(), UniconsLine.plus_circle,
                  "New Request"),
              customCard(
                  context, OwnFlatPage(), UniconsLine.bolt, "Your Requests"),
              customCard(context, null, UniconsLine.setting, "Setting"),
              customCard(context, null, UniconsLine.question_circle, "Help"),
              customCard(
                  context, null, UniconsLine.file_alt, "Privacy Policys"),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: customYellow,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minimumSize: const Size(200, 40)),
                onPressed: () {},
                child: Text(
                  "Log Out",
                  style: AppStyles.mondaB.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget customCard(
  BuildContext context,
  Widget? widget,
  IconData icon,
  String title,
) {
  return InkWell(
    onTap: () {
      (widget != null)
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget,
              ))
          : null;
    },
    child: Card(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: customYellow,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: AppStyles.mondaB.copyWith(fontSize: 18),
                ),
              ],
            ),
            Icon(
              UniconsLine.angle_right,
              color: customYellow,
              size: 35,
            ),
          ],
        ),
      ),
    ),
  );
}
