import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/flat_model.dart';
import 'package:flatmates/pages/home/widget/home_page_flat_card.dart';
import 'package:flatmates/pages/home/widget/home_page_flat_card_skelaton.dart';
import 'package:flatmates/provider/flat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShortListPage extends StatefulWidget {
  const ShortListPage({super.key});

  @override
  State<ShortListPage> createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
  bool isRefreshing = false;
  Future<void> fetch(bool isRefresh) async {
    try {
      if (isRefresh) {
        await Provider.of<FlatProvider>(context, listen: false)
            .fetchAllFavFlats(true);
      } else {
        if (!Provider.of<FlatProvider>(context, listen: false)
            .favFlatListFetched) {
          await Provider.of<FlatProvider>(context, listen: false)
              .fetchAllFavFlats(false);
        }
      }
    } catch (e) {
      showSnackBarOnPage(
          "Something went wrong while fetching shortlisted Flats");
    }
  }

  void showSnackBarOnPage(String content) {
    SnackBar snackBar = SnackBar(content: Text(content));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "ShortListed",
          style: AppStyles.mondaB.copyWith(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          setState(() {
            isRefreshing = true;
          });
          await fetch(true);
          setState(() {
            isRefreshing = false;
          });
        },
        child: FutureBuilder<void>(
          future: fetch(false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                isRefreshing) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return HomePageFlatCardSkelaton();
                },
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<FlatProvider>(
                builder: (context, value, child) {
                  List<Flat> flats = value.favflatList;
                  if (flats.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/error.png",
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: Text(
                              "There is no data",
                              textAlign: TextAlign.center,
                              style: AppStyles.mondaB.copyWith(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: customYellow,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                minimumSize: const Size(200, 40)),
                            onPressed: () {
                              fetch(true);
                            },
                            child: Text(
                              "Refresh",
                              style: AppStyles.mondaB.copyWith(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: flats.length,
                      itemBuilder: (context, index) {
                        return HomePageFlatCard(
                          flat: flats[index],
                        );
                      },
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/error.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      child: Text(
                        "There is no data",
                        textAlign: TextAlign.center,
                        style: AppStyles.mondaB.copyWith(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: customYellow,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(200, 40)),
                      onPressed: () {
                        fetch(true);
                      },
                      child: Text(
                        "Refresh",
                        style: AppStyles.mondaB.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
