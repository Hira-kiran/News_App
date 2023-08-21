import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/news_catagories_model.dart';
import '../resourses/resourses.dart';
import '../view_model/news_view_model.dart';
import 'home_screen.dart';

class NewsCategoriesScreen extends StatefulWidget {
  const NewsCategoriesScreen({super.key});

  @override
  State<NewsCategoriesScreen> createState() => _NewsCategoriesScreenState();
}

class _NewsCategoriesScreenState extends State<NewsCategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");
  FilterList? selectedItem;
  String catagoriesName = "General";

  List<String> categoriesList = [
    "General",
    "Health",
    "Entertainment",
    "Supports",
    "Bussiness",
    "Tecnology"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.055,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        catagoriesName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: width * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: R.appColors.purple),
                              color: catagoriesName == categoriesList[index]
                                  ? R.appColors.purple
                                  : R.appColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.03),
                            child: Center(
                                child: Text(
                              categoriesList[index].toString(),
                              style: R.appTextStyle.inter(
                                  color: catagoriesName == categoriesList[index]
                                      ? R.appColors.white
                                      : R.appColors.purple),
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: FutureBuilder<NewsCategoriesModel>(
                  future: newsViewModel.newsCatagoriesAPi(catagoriesName),
                  builder: (BuildContext cotext, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: R.appSpinKits.spinKitFadingCube,
                      );
                    } else {
                      return ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: height * 0.2,
                                    width: width * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            R.appSpinKits.spinKitFadingCube,
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: R.appColors.red,
                                        ),
                                      ),
                                     ),
                                 ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: height * .1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.5,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: R.appTextStyle
                                                  .inter(fontsize: 12),
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: R.appTextStyle.inter(
                                                    color: R.appColors.purple),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: R.appTextStyle.inter(
                                                    fontsize: 12,
                                                    color: R.appColors.grey),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
