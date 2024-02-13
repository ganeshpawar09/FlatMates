import 'package:carousel_slider/carousel_slider.dart';
import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/flat_model.dart';
import 'package:flatmates/pages/home/home_detail_page.dart';
import 'package:flatmates/provider/flat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';

class HomePageFlatCard extends StatefulWidget {
  final Flat flat;
  const HomePageFlatCard({super.key, required this.flat});

  @override
  State<HomePageFlatCard> createState() => _HomePageFlatCardState();
}

class _HomePageFlatCardState extends State<HomePageFlatCard> {
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

  @override
  Widget build(BuildContext context) {
    final images = widget.flat.flatPhotos;
    String buildingName = widget.flat.buildingName;
    String cityName = widget.flat.city;
    String address = widget.flat.address;
    String preference = widget.flat.flatmatePreference;
    int rent = widget.flat.rent;
    bool favorite = widget.flat.favourite;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDetailPage(flat: widget.flat),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
        child: Card(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        // autoPlay: true,
                        aspectRatio: 1,
                        viewportFraction: 1,
                        height: 180,
                        autoPlayAnimationDuration: Duration(seconds: 8),
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) {
                        return Image.network(
                          images[index],
                          errorBuilder: (context, error, stackTrace) {
                            return Text("Not Available");
                          },
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 15),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              icon: (favorite)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      UniconsLine.heart,
                                    ),
                              onPressed: () {
                                setState(() {
                                  toggle(widget.flat.id, favorite);
                                  widget.flat.favourite =
                                      !widget.flat.favourite;
                                });
                              }),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$buildingName",
                        style: AppStyles.mondaB.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      (preference.startsWith("male"))
                          ? customRow(Icons.man_outlined, "", "For Boys Only")
                          : (preference == "female")
                              ? customRow(
                                  Icons.woman_2_outlined, "", "For Girls Only")
                              : customRow(Icons.bolt, "", "For All"),
                      customRow(UniconsLine.bed, "", "2 Flatmates Required"),
                      customRow(UniconsLine.location_point, "",
                          "$address, $cityName"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "₹ $rent",
                                  style:
                                      AppStyles.mondaB.copyWith(fontSize: 20),
                                ),
                                TextSpan(
                                  text: "Per Month",
                                  style:
                                      AppStyles.mondaB.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customRow(IconData? icon, String? imageLocation, String title) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (icon != null)
              ? Icon(
                  icon,
                  color: customYellow,
                  size: 22,
                )
              : Image.asset(
                  imageLocation!,
                  height: 20,
                  width: 20,
                ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              title,
              style: AppStyles.mondaN
                  .copyWith(color: Colors.black54, fontSize: 15),
            ),
          )
        ],
      ),
      SizedBox(
        height: 3,
      ),
    ],
  );
}
