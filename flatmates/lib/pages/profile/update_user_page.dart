import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserPage extends StatefulWidget {
  final String userName, phoneNumber;

  const UpdateUserPage(
      {Key? key, required this.userName, required this.phoneNumber})
      : super(key: key);

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userName;
    phoneNumberController.text = widget.phoneNumber;
  }

  void showSnackBarOnPage(String content) {
    SnackBar snackBar = SnackBar(content: Text(content));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void saveChange() async {
    // String name = nameController.text;
    // if (name.isEmpty) {
    //   showSnackBarOnPage("Name field Required");
    //   return;
    // }

    // bool isChange = await Provider.of<UserProvider>(context, listen: false)
    //     .updateUser(name);

    // if (isChange) {
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   preferences.setString("userName", name);
    //   showSnackBarOnPage("Name Change Successfully");
    // }
  }

  Widget customTextFormField(
    String label,
    bool readOnly,
    TextInputType type,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.mondaB.copyWith(color: Colors.black, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          keyboardType: type,
          readOnly: readOnly,
          maxLength: 10,
          cursorColor: Colors.black54,
          style: AppStyles.mondaB.copyWith(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            counter: const SizedBox(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            focusColor: Colors.black,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: AppStyles.mondaB.copyWith(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              customTextFormField(
                "Name",
                false,
                TextInputType.text,
                nameController,
              ),
              customTextFormField(
                "Mobile Number",
                true,
                TextInputType.number,
                phoneNumberController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: customYellow,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: const Size(200, 40),
                ),
                onPressed: saveChange,
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    if (value.isloading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text(
                        "Save Changes",
                        style: AppStyles.mondaB.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
