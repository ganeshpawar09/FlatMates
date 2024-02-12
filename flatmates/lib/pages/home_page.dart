import 'package:flatmates/const/colors.dart';
import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/flat_model.dart';
import 'package:flatmates/provider/flat_provider.dart';
import 'package:flatmates/provider/socket_provider.dart';
import 'package:flatmates/widget/home_page_filter_card_skelaton.dart';
import 'package:flatmates/widget/home_page_flat_card_skelaton.dart';
import 'package:flatmates/widget/home_page_flat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget Function()> filter = [];
  late IO.Socket socket;
  bool appbar = true;
  bool islowtohigh = false;
  bool ishightolow = false;
  bool isforboys = false;
  bool isforgirls = false;
  bool isPrice = false;
  bool isSearch = false;

  String sortby = "lowtohigh";
  String faltmatePreference = "any";
  String search = "";
  double minValue = 0;
  double maxValue = 100000;

  void clearFilter() {
    islowtohigh = false;
    ishightolow = false;
    isforboys = false;
    isforgirls = false;
    isPrice = false;
    isSearch = false;
  }

  Future<void> filterFetch(bool isLoadMore) async {
    FlatProvider flatProvider =
        Provider.of<FlatProvider>(context, listen: false);
    if (!isLoadMore) {
      flatProvider.flatPage = 0;
    }
    String filterString =
        "?page=${flatProvider.flatPage}&limit=${flatProvider.flatPageLimit}";

    if (ishightolow || islowtohigh) {
      filterString += "&sortby=$sortby";
    }

    if (isforboys || isforgirls) {
      filterString += "&preference=$faltmatePreference";
    }

    if (isPrice) {
      filterString += "&min=$minValue&max=$maxValue";
    }

    if (isSearch) {
      filterString += "&search=$search";
    }

    if (!isLoadMore) {
      flatProvider.flatPage = 0;
    }

    await flatProvider.fetchAllFlats(!isLoadMore, filterString);
  }

  Future<void> fetch() async {
    await Provider.of<FlatProvider>(context, listen: false)
        .fetchAllFlats(true, "");
  }

  void connectToServer() async {
    socket = IO.io('https://flatmates.onrender.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('Connected to server');
      print('Socket ID: ${socket.id}');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    await socket.connect();
  }

  @override
  void initState() {
    super.initState();
    filter = [sortByWidget, priceFilterWidget, preferenceWidget, clearWidget];

    // if (!Provider.of<FlatProvider>(context, listen: false).flatListFetched) {
    //   Provider.of<FlatProvider>(context, listen: false)
    //       .fetchAllFlats(false, "");
    // }
    connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (appbar)
          ? AppBar(
              elevation: 0,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Flat",
                      style: AppStyles.mondaB.copyWith(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Mates",
                      style: AppStyles.mondaB.copyWith(
                          fontSize: 30,
                          color: customYellow,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      appbar = false;
                    });
                  },
                  icon: Icon(
                    UniconsLine.search,
                    color: customYellow,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            )
          : AppBar(
              elevation: 0,
              title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField()),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      appbar = true;
                    });
                  },
                  icon: Icon(
                    UniconsLine.abacus,
                    color: customYellow,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          fetch();
        },
        child: Consumer<FlatProvider>(
          builder: (context, value, child) {
            List<Flat> flats = value.flatList;
            if (flats.isEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return HomePageFilterCardSkelaton();
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return HomePageFlatCardSkelaton();
                      },
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filter.length,
                      itemBuilder: (context, index) {
                        return filter[index]();
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: flats.length + 1,
                      itemBuilder: (context, index) {
                        return (index == flats.length)
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 30),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: customYellow,
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      minimumSize: const Size(200, 40)),
                                  onPressed: () {
                                    filterFetch(true);
                                  },
                                  child: Text(
                                    "Load More",
                                    style: AppStyles.mondaB.copyWith(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            : HomePageFlatCard(
                                flat: flats[index],
                              );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget sortByWidget() {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 5, bottom: 5),
      padding: EdgeInsets.only(right: 5, left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: (ishightolow || islowtohigh) ? customYellow : Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          islowtohigh = true;
                          ishightolow = false;
                        });
                        sortby = "lowtohigh";
                        Navigator.pop(context);

                        filterFetch(false);
                      },
                      child: Text(
                        "Price (Low to High)",
                        style: AppStyles.mondaB.copyWith(
                            color: (islowtohigh) ? customYellow : Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          islowtohigh = false;
                          ishightolow = true;
                        });
                        sortby = "hightolow";
                        Navigator.pop(context);
                        filterFetch(false);
                      },
                      child: Text(
                        "Price (High to Low)",
                        style: AppStyles.mondaB.copyWith(
                            color: (ishightolow) ? customYellow : Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Center(
          child: Row(
            children: [
              Text(
                "Sort By",
                style: AppStyles.mondaB.copyWith(
                  fontSize: 14,
                  color: (ishightolow || islowtohigh)
                      ? customYellow
                      : Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 25,
                color:
                    (ishightolow || islowtohigh) ? customYellow : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget preferenceWidget() {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 5, bottom: 5),
      padding: EdgeInsets.only(right: 5, left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: (isforboys || isforgirls) ? customYellow : Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isforgirls = false;
                          isforboys = true;
                        });
                        faltmatePreference = "male";
                        Navigator.pop(context);

                        filterFetch(false);
                      },
                      child: Text(
                        "Boys",
                        style: AppStyles.mondaB.copyWith(
                            color: (isforboys) ? customYellow : Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isforgirls = true;
                          isforboys = false;
                        });
                        faltmatePreference = "female";
                        Navigator.pop(context);
                        filterFetch(false);
                      },
                      child: Text(
                        "Girls",
                        style: AppStyles.mondaB.copyWith(
                            color: (isforgirls) ? customYellow : Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Center(
          child: Row(
            children: [
              Text(
                "For",
                style: AppStyles.mondaB.copyWith(
                  fontSize: 14,
                  color:
                      (isforboys || isforgirls) ? customYellow : Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 25,
                color: (isforboys || isforgirls) ? customYellow : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceFilterWidget() {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 5, bottom: 5),
      padding: EdgeInsets.only(right: 5, left: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: (isPrice) ? customYellow : Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: RangeSlider(
                            activeColor: customYellow,
                            inactiveColor: Colors.black,
                            labels: RangeLabels("$minValue", "$maxValue"),
                            max: 100000,
                            min: 0,
                            values: RangeValues(minValue, maxValue),
                            onChanged: (RangeValues values) {
                              setState(() {
                                minValue = values.start;
                                maxValue = values.end;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Low: ${minValue.toStringAsFixed(0)}",
                                  style:
                                      AppStyles.mondaB.copyWith(fontSize: 16)),
                              Text("High: ${maxValue.toStringAsFixed(0)}",
                                  style:
                                      AppStyles.mondaB.copyWith(fontSize: 16))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: customYellow,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              minimumSize: const Size(200, 40)),
                          onPressed: () {
                            isPrice = true;
                            Navigator.pop(context);
                            filterFetch(false);
                          },
                          child: Text(
                            "Apply",
                            style: AppStyles.mondaB.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: Center(
          child: Row(
            children: [
              Text(
                "Price",
                style: AppStyles.mondaB.copyWith(
                  fontSize: 14,
                  color: (isPrice) ? customYellow : Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 25,
                color: (isPrice) ? customYellow : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget clearWidget() {
    return InkWell(
      onTap: () {
        clearFilter();
        filterFetch(false);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, top: 5, bottom: 5),
        padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            "Clear",
            style: AppStyles.mondaB.copyWith(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
