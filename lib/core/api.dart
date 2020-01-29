import 'dart:async';
import 'dart:convert';

import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/model/serializers.dart';
import 'package:http/http.dart' show Client;

abstract class ApiProvider {
  Future<List<News>> fetchNews({int offset, NewsFeedType feedType});
  Future<List<News>> searchNews({String query, int offset});
}

enum NewsFeedType { trending, latest }

class RemoteRepository extends ApiProvider {
  Client client = Client();
  final String _baseUrl = 'api.coronatracker.com';

  Future<List<News>> fetchNews({
    int offset = 0,
    NewsFeedType feedType = NewsFeedType.trending,
  }) async {
    var endpoint;
    switch (feedType) {
      case NewsFeedType.trending:
        endpoint = Uri.https(
            _baseUrl, "/news/trending", {"offset": offset.toString()});

        final response = await client.get(endpoint);

        if (response.statusCode == 200) {
          final Map<String, dynamic> articlesDataMap =
              json.decode(response.body);
          final Iterable articlesData = articlesDataMap['items'];

          return articlesData.map((data) => deserialize<News>(data)).toList();
        } else {
          return [];
        }
        break;
      case NewsFeedType.latest:
        endpoint = Uri.https(_baseUrl, "/news",
            {"offset": offset.toString(), "sort": "-publishedAt"});

        final response = await client.get(endpoint);

        if (response.statusCode == 200) {
          final Iterable articlesData = json.decode(response.body);
          return articlesData.map((data) => deserialize<News>(data)).toList();
        } else {
          return [];
        }
        break;
    }
    return [];
  }

  Future<List<News>> searchNews({
    String query,
    int offset = 0,
  }) async {
    var endpoint = Uri.https(_baseUrl, "/news", {
      "q": query,
      "offset": offset.toString(),
    });
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      final Iterable articlesData = json.decode(response.body);
      return articlesData.map((data) => deserialize<News>(data)).toList();
    } else {
      return null;
    }
  }
}
