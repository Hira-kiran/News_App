import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel_headline_model.dart';
import '../models/news_catagories_model.dart';
import '../resourses/resourses.dart';
import '../view_model/news_view_model.dart';
import 'news_catagories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  aryNews,
  bbcNews,
  abcNews,
  cnn,
  focus,
  foxNews,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");

  FilterList? selectedItem;
  String name = "bbc-news";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewsCategoriesScreen()));
          },
          child: const Icon(
            Icons.category,
          ),
        ),
        title: Text(
          "News",
          style: R.appTextStyle.poppins(),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              onSelected: (FilterList item) {
                if (FilterList.aryNews.name == item.name) {
                  name = "ary-news";
                }
                if (FilterList.bbcNews.name == item.name) {
                  name = "bbc-news";
                }
                if (FilterList.abcNews.name == item.name) {
                  name = "abc-news";
                }
                if (FilterList.focus.name == item.name) {
                  name = "focus";
                }
                if (FilterList.foxNews.name == item.name) {
                  name = "fox-news";
                }

                setState(() {
                  selectedItem = item;
                });
              },
              initialValue: selectedItem,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                        value: FilterList.aryNews, child: Text("ARY News")),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text("BBC News")),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.abcNews, child: Text("ABC News")),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.focus, child: Text("Focus News")),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.foxNews, child: Text("Fox News")),
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.5,
            width: width,
            child: FutureBuilder<NewsChannelHeadlineModel>(
                future: newsViewModel.fatchNewsChannelHeadlineApi(name),
                builder: (BuildContext cotext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: R.appSpinKits.spinKitFadingCube,
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03,
                                        vertical: height * 0.02),
                                    height: height * 0.5,
                                    width: width * 0.8,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      /*     child: CachedNetworkImage(
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
                                      ), */
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    left: 20,
                                    right: 20,
                                    child: Card(
                                      shadowColor: R.appColors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        height: height * 0.15,
                                        width: width * 0.7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: R.appColors.white),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.025,
                                              vertical: height * 0.015),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: R.appTextStyle.inter(),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: R.appTextStyle.inter(
                                                        color:
                                                            R.appColors.purple),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    style: R.appTextStyle.inter(
                                                        fontsize: 12,
                                                        color:
                                                            R.appColors.grey),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                  }
                }),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*0.04),
            child: FutureBuilder<NewsCategoriesModel>(
                future: newsViewModel.newsCatagoriesAPi("general"),
                builder: (BuildContext cotext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: R.appSpinKits.spinKitFadingCube,
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
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
                                      child: Container(
                                        color: R.appColors.blackColor,
                                      )),
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
                                            snapshot.data!.articles![index].title
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
    );
  }
}
