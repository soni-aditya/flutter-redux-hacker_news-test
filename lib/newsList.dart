import 'package:flutter/material.dart';
import 'package:news_rxdart/bloc/newsBloc.dart';

class NewsList extends StatelessWidget {
  NewsBloc bloc = NewsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.fetchNewsIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
      ),
      body: StreamBuilder(
        stream: bloc.newsStream,
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<List> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(snapshot.data[index].toString());
      },
    );
  }
}
