import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flutter/material.dart';

class UploadNewRequest extends StatefulWidget {
  const UploadNewRequest({super.key});

  @override
  State<UploadNewRequest> createState() => _UploadNewRequestState();
}

class _UploadNewRequestState extends State<UploadNewRequest> {
  final apartmentList = ["1 Rk", "1 Bhk", "2 Bhk", "3 Bhk", "4 Bhk"];
  final furnishList = ["Furnished", "Semi-Furnished", "Unfurnished"];
  final waterSupplyList = ["24/7", "Limited Time", "No supply"];
  String furnish = "Furnished";
  String waterSupply = "24/7";
  String apartment = "1 Rk";
  bool galleryAvailable = false;
  bool parkingAvailable = false;
  bool cctvAvailable = false;
  bool securityAvailable = false;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "New Request",
          style: AppStyles.mondaB.copyWith(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                customTextFormField("Bulding Name*"),
                customTextFormField("Address*"),
                customTextFormField("LandMark*"),
                Row(
                  children: [
                    Expanded(child: customTextFormField("City*")),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: customTextFormField("Pincode*"))
                  ],
                ),
                customTextFormField("State*"),
                customTextFormField("Description of Flat*"),
                Row(
                  children: [
                    Expanded(child: customTextFormField("Flatmates Needed*")),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: customTextFormField("Current Flatmates*"))
                  ],
                ),
                customTextFormField("Rent Per Person*"),
                customTextFormField("Apartment Type*"),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Water Supply",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1)),
                      child: DropdownButton<String>(
                        value: waterSupply,
                        items: waterSupplyList.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              style: AppStyles.mondaB
                                  .copyWith(color: Colors.black54),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            waterSupply = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Apartment Type",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1)),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: apartment,
                        items: apartmentList.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              style: AppStyles.mondaB
                                  .copyWith(color: Colors.black54),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            apartment = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Furnished",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1)),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: furnish,
                        items: furnishList.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              style: AppStyles.mondaB
                                  .copyWith(color: Colors.black54),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            furnish = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                buildCheckbox("Gallery Available", galleryAvailable, (value) {
                  setState(() {
                    galleryAvailable = value;
                  });
                }),
                buildCheckbox("Parking Available", parkingAvailable, (value) {
                  setState(() {
                    parkingAvailable = value;
                  });
                }),
                buildCheckbox("CCTV Available", cctvAvailable, (value) {
                  setState(() {
                    cctvAvailable = value;
                  });
                }),
                buildCheckbox(
                  "Security Available",
                  securityAvailable,
                  (value) {
                    setState(() {
                      securityAvailable = value;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: customYellow,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(200, 40)),
                      onPressed: () {},
                      child: Text(
                        "Upload",
                        style: AppStyles.mondaB.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckbox(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.mondaN.copyWith(fontSize: 18),
        ),
        Checkbox(
          activeColor: customYellow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          value: value,
          onChanged: (value) {
            onChanged(value!);
          },
        ),
      ],
    );
  }
}

Widget customTextFormField(String title) {
  return Column(
    children: [
      TextFormField(
        cursorColor: Colors.black54,
        style: AppStyles.mondaB.copyWith(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          label: Text(title),
          labelStyle:
              AppStyles.mondaN.copyWith(color: Colors.black54, fontSize: 18),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          focusColor: Colors.black,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
