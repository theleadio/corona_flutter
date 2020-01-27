import 'dart:async';
import 'dart:convert';

import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/model/serializers.dart';
import 'package:http/http.dart' show Client;

abstract class ApiProvider {
  Future<List<News>> fetchNews({int offset, NewsFeedType feed});
  Future<List<News>> searchNews({String query, int offset});
}

enum NewsFeedType { trending, latest }

class RemoteRepository extends ApiProvider {
  Client client = Client();
  final String _baseUrl = 'api.coronatracker.com';

  Future<List<News>> fetchNews({
    int offset = 0,
    NewsFeedType feed = NewsFeedType.trending,
  }) async {
    var endpoint = Uri.https(_baseUrl, "/news", {"offset": offset.toString()});
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      final Iterable articlesData = json.decode(response.body);
      return articlesData.map((data) => deserialize<News>(data)).toList();
    } else {
      return null;
    }
  }

  Future<List<News>> searchNews({
    String query,
    int offset = 0,
  }) async {
    var endpoint = Uri.https(_baseUrl, "/news", {"q": query});
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      final Iterable articlesData = json.decode(response.body);
      return articlesData.map((data) => deserialize<News>(data)).toList();
    } else {
      return null;
    }
  }
}
