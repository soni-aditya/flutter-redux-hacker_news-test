class UrlConstants {
  static String newsIds =
      'https://hacker-news.firebaseio.com/v0/askstories.json?print=pretty';

  static String getNewsDetails(int newsId) {
    return 'https://hacker-news.firebaseio.com/v0/item/$newsId.json?print=pretty';
  }
}
