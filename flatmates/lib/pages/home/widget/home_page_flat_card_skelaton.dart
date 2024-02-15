import 'package:flatmates/widget/skelaton_widget.dart';
import 'package:flutter/material.dart';

class HomePageFlatCardSkelaton extends StatelessWidget {
  const HomePageFlatCardSkelaton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child:const  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SkelatonWidget(height:180,width: double.infinity),
              Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkelatonWidget(height:30, width:250),
                    SizedBox(
                      height: 8,
                    ),
                    SkelatonWidget(height:30, width:150),
                    SizedBox(
                      height: 3,
                    ),
                    SkelatonWidget(height:30, width:180),
                    SizedBox(
                      height: 3,
                    ),
                    SkelatonWidget(height:30, width:230),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SkelatonWidget(height:40, width:150),
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
    );
  }
}


