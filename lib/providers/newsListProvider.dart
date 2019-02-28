import 'dart:convert';

import 'package:news_rxdart/constants/url_constants.dart';
import 'package:news_rxdart/serializers/news.dart';
import 'package:news_rxdart/serializers/news_id_list.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NewsListProvider {
  static Future<NewsIdList> fetchNewsIdList() async {
    final response = await http.get(UrlConstants.newsIds);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var parsedJson = json.decode(response.body);
      print('News IDs List => ${parsedJson.toString()}');
      return NewsIdList.fromJson(parsedJson);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<List<News>> fetchNewsList() async {
    List<News> newsList = [];
    await fetchNewsIdList().then((NewsIdList newsIdList) async {
      print('HERE');
//      for (int id in newsIdList.topStoryIndexes) {
      for (int index = 0; index < 5; index++) {
        String url =
            UrlConstants.getNewsDetails(newsIdList.topStoryIndexes[index]);
        final response = await http.get(url);

        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON
          var parsedJson = json.decode(response.body);
          print('NEws - $parsedJson');
          newsList.add(News.fromJson(parsedJson));
        } else {
          // If that call was not successful, throw an error.
          throw Exception(
              'Failed to load post for Id ${newsIdList.topStoryIndexes[index]}');
        }
      }
    });
    return newsList;
//    Future.wait(newsIdList.topStoryIndexes.map((newsId) async {

//    })).whenComplete(() {
//      return newsList;
//    });
  }
}
