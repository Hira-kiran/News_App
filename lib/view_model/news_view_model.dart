import 'package:news_app/models/news_channel_headline_model.dart';
import '../repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelHeadlineModel> fatchNewsChannelHeadlineApi() async {
    final response = await _repo.fatchNewsChannelHeadlineApi();
    return response;
  }
}
