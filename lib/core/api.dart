import 'dart:async';
import 'dart:convert';

import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/model/serializers.dart';
import 'package:http/http.dart' show Client;

abstract class ApiProvider {
  Future<List<News>> fetchNews(
      {int offset, NewsFeedType feedType, String country});
  Future<List<News>> searchNews({String query, int offset});
  Future<StatsCounter> getStats({String country});
}

enum NewsFeedType { trending, latest }

class RemoteRepository extends ApiProvider {
  Client client = Client();
  final String _baseUrl = 'api.coronatracker.com';

  Future<List<News>> fetchNews({
    int offset = 0,
    NewsFeedType feedType = NewsFeedType.trending,
    String country = '',
  }) async {
    Map<String, String> query = {
      "offset": offset.toString(),
      "country": country,
    };
    if (country.length <= 0) {
      query.remove("country");
    }

    var endpoint;
    switch (feedType) {
      case NewsFeedType.trending:
        endpoint = Uri.https(_baseUrl, "/news/trending", query);

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
        query["sort"] = "-publisedAt";
        endpoint = Uri.https(_baseUrl, "/news", query);

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

  Future<StatsCounter> getStats({
    String country = '',
  }) async {
    Map<String, String> query = {};
    if (country.length > 0) {
      query = {
        "country": country,
      };
    }

    var endpoint = Uri.https(_baseUrl, "/stats", query);
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      final statsData = json.decode(response.body);
      return deserialize<StatsCounter>(statsData);
    } else {
      return null;
    }
  }
}
