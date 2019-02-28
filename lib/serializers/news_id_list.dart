class NewsIdList {
  List topStoryIndexes = [];

  NewsIdList({this.topStoryIndexes});

  factory NewsIdList.fromJson(List<dynamic> newsList) {
    return NewsIdList(topStoryIndexes: newsList);
  }
}
