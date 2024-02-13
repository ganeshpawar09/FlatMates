import 'package:carousel_slider/carousel_slider.dart';
import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/flat_model.dart';
import 'package:flatmates/provider/flat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';

class HomeDetailPage extends StatefulWidget {
  final Flat flat;
  const HomeDetailPage({super.key, required this.flat});

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  int _currImage = 0;
  Future<void> toggle(String flatId, bool isFavourite) async {
    if (isFavourite) {
      await Provider.of<FlatProvider>(context, listen: false)
          .removeFlatToFavourite(flatId);
    } else {
      await Provider.of<FlatProvider>(context, listen: false)
          .addFlatToFavourite(flatId);
    }
  }

  final feature = [];
  @override
  void initState() {
    super.initState();
    timepass(widget.flat);
  }

  void timepass(Flat flat) {
    if (flat.flatmatePreference == 'male') {
      feature.add("For: Boys");
    } else if (flat.flatmatePreference == 'female') {
      feature.add("For: Girls");
    } else {
      feature.add("For: Any");
    }
    if (flat.parkingAvailable) {
      feature.add("Parking Available");
    }
    if (flat.galleryAvailable) {
      feature.add("Gallery Available");
    }
    if (flat.securityAvailable) {
      feature.add("Security Available");
    }
    feature.add("Water Supply: ${flat.waterSupply}");
  }

  @override
  Widget build(BuildContext context) {
    final flat = widget.flat;
    final images = flat.flatPhotos;
    String buildingName = flat.buildingName;
    String cityName = flat.city;
    String address = flat.address;
    String preference = flat.flatmatePreference;
    int rent = flat.rent;
    bool favorite = flat.favourite;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: (favorite)
                    ? Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.red,
                      )
                    : Icon(
                        UniconsLine.heart_alt,
                        size: 30,
                      ),
                onPressed: () {
                  setState(
                    () {
                      toggle(widget.flat.id, favorite);
                      widget.flat.favourite = !widget.flat.favourite;
                    },
                  );
                },
              ),
              SizedBox(
                width: 30,
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currImage = index;
                        });
                      },
                      autoPlay: true,
                      aspectRatio: 1,
                      viewportFraction: 1,
                      height: 240,
                      autoPlayAnimationDuration: Duration(seconds: 8),
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          images[index],
                          errorBuilder: (context, error, stackTrace) {
                            return Text("Not Available");
                          },
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedSmoothIndicator(
                          activeIndex: _currImage,
                          count: images.length,
                          effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: customYellow,
                              dotColor: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$buildingName",
                style: AppStyles.mondaB.copyWith(fontSize: 22),
              ),
              Text(
                "$address",
                style: AppStyles.mondaN
                    .copyWith(fontSize: 16, color: Colors.black87),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "₹ $rent",
                          style: AppStyles.mondaB.copyWith(fontSize: 20),
                        ),
                        TextSpan(
                          text: "Per Month",
                          style: AppStyles.mondaB.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Wrap(
                spacing: 5.0,
                children: feature.map((item) {
                  return Chip(
                    avatar: Icon(
                      UniconsLine.bolt,
                      color: customYellow,
                    ),
                    label: Text(
                      item,
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 13, color: Colors.black),
                    ),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 0, color: Colors.grey[200]!)),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Description",
                style: AppStyles.mondaB.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${flat.description}",
                style: AppStyles.mondaN.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: customYellow,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              minimumSize: const Size(200, 40)),
          onPressed: () {},
          child: Text(
            "Chat To Owner",
            style: AppStyles.mondaB.copyWith(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
