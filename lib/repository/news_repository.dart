import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/news_catagories_model.dart';
import '../models/news_channel_headline_model.dart';

class NewsRepository {
  Future<NewsChannelHeadlineModel> fatchNewsChannelHeadlineApi(
      String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=049f6308db2743f79cc91c617689d95c";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body.toString());
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception("Something went wrone");
  }
   Future<NewsCategoriesModel> newsCatagoriesAPi(
      String categories) async {
    String url =
        "https://newsapi.org/v2/everything?q=$categories&apiKey=049f6308db2743f79cc91c617689d95c";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body.toString());
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsCategoriesModel.fromJson(body);
    }
    throw Exception("Something went wrone");
  }
}
