import 'package:news_rxdart/providers/newsListProvider.dart';
import 'package:news_rxdart/serializers/news.dart';
import 'package:news_rxdart/serializers/news_id_list.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  //Subject <-> StreamController => kind of a listener/pipe
  final _newsFetcher = PublishSubject<List>();

  //Observable <-> Stream => Output endpoint for Subject
  Observable<List> get newsStream => _newsFetcher.stream;

  //Giving input to our stream
  fetchNewsIds() async {
    print('Hi');
    await NewsListProvider.fetchNewsList().then((newsList) {
      print('NEWS - $newsList');
      _newsFetcher.sink.add(newsList);
    });
  }

  //Terminating the stream
  dispose() {
    _newsFetcher.close();
  }
}
