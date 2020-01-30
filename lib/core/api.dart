import 'dart:async';
import 'dart:convert';

import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/model/serializers.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:http/http.dart' show Client;

abstract class ApiProvider {
  Future<List<News>> fetchNews(
      {int offset, NewsFeedType feedType, String countryCode});
  Future<List<News>> searchNews({String query, int offset});
  Future<StatsCounter> getStats({String countryCode});
}

enum NewsFeedType { trending, latest }

class RemoteRepository extends ApiProvider {
  Client client = Client();
  final String _baseUrl = 'api.coronatracker.com';

  Future<List<News>> fetchNews({
    int offset = 0,
    NewsFeedType feedType = NewsFeedType.trending,
    String countryCode = 'GLOBAL',
  }) async {
    Map<String, String> query = {
      "offset": offset.toString(),
      "country": Helper.getCountryName(countryCode),
    };
    if (countryCode == 'GLOBAL') {
      query.remove("country");
    }

    var endpoint;
    switch (feedType) {
      case NewsFeedType.trending:
        endpoint = Uri.https(_baseUrl, "/news/trending", query);
        print(endpoint.toString());
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
        query["sort"] = "-publishedAt";
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
    String countryCode = '',
  }) async {
    Map<String, String> query = {};
    if (countryCode.length > 0 && countryCode != 'GLOBAL') {
      query = {
        "country": Helper.getCountryName(countryCode),
      };
    }

    var endpoint = Uri.https(_baseUrl, "/stats", query);
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      try {
        final statsData = json.decode(response.body);
        return deserialize<StatsCounter>(statsData);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
