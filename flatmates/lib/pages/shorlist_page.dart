import 'package:flatmates/const/font.dart';
import 'package:flatmates/models/flat_model.dart';
import 'package:flatmates/provider/flat_provider.dart';
import 'package:flatmates/widget/home_page_flat_card.dart';
import 'package:flatmates/widget/home_page_flat_card_skelaton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShortListPage extends StatefulWidget {
  const ShortListPage({super.key});

  @override
  State<ShortListPage> createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
  Future<void> fetch() async {
    await Provider.of<FlatProvider>(context, listen: false)
        .fetchAllFavFlats(true);
  }

  @override
  void initState() {
    super.initState();
    if (!Provider.of<FlatProvider>(context, listen: false).favFlatListFetched)
      Provider.of<FlatProvider>(context, listen: false).fetchAllFavFlats(false);
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
            fetch();
          },
          child: Consumer<FlatProvider>(
            builder: (context, value, child) {
              List<Flat> flats = value.favflatList;
              if (flats.isEmpty) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return HomePageFlatCardSkelaton();
                  },
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
          ),
        ));
  }
}
