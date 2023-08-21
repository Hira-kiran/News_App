import 'package:news_app/models/news_channel_headline_model.dart';
import '../models/news_catagories_model.dart';
import '../repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelHeadlineModel> fatchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _repo.fatchNewsChannelHeadlineApi(channelName);
    return response;
  }

  Future<NewsCategoriesModel> newsCatagoriesAPi(String categories) async {
    final response = await _repo.newsCatagoriesAPi(categories);
    return response;
  }
}
