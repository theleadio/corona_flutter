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
  Future<List<Hospital>> getHospitals();
}

enum NewsFeedType { trending, latest }

class RemoteRepository extends ApiProvider {
  Client client = Client();
  final String _baseUrl = 'api.coronatracker.com';

  /// Fetch news from API endpoint.
  ///
  /// [offset] defines numbers of news to be skipped from query, typically for pagination purpose.
  /// [feedType] defines user news preferences, either by trending or sort by latest.
  /// [countryCode] defines the country code to retrieve news specifically about the country.
  Future<List<News>> fetchNews({
    int offset = 0,
    NewsFeedType feedType = NewsFeedType.trending,
    String countryCode = 'GLOBAL',
  }) async {
    Map<String, String> query = {
      "offset": offset.toString(),
      "country": Helper.getCountryName(countryCode),
      "limit": "10",
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

  /// Search news from API endpoint using [query].
  ///
  /// [offset] defines numbers of news to be skipped from query, typically for pagination purpose.
  Future<List<News>> searchNews({
    String query,
    int offset = 0,
  }) async {
    var endpoint = Uri.https(_baseUrl, "/news", {
      "q": query,
      "offset": offset.toString(),
      "limit": "10",
    });
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      final Iterable articlesData = json.decode(response.body);
      return articlesData.map((data) => deserialize<News>(data)).toList();
    } else {
      return null;
    }
  }

  /// Fetch statistics from API endpoint based on [countryCode].
  /// If [countryCode] is empty, it will retrieve latest statistics in the world.
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

  /// Fetch all hospitals' details from API endpoint.
  Future<List<Hospital>> getHospitals() async {
    var endpoint = Uri.https(
      "v2-api.sheety.co",
      "/3d29e508008ed3f47cc52f6aaf321f51/coronaInfo/hospitalsAndHealthcareProviders",
    );
    final response = await client.get(endpoint);

    if (response.statusCode == 200) {
      final Map<String, dynamic> hospitalDataMap = json.decode(response.body);
      final Iterable hospitalData =
          hospitalDataMap['hospitalsAndHealthcareProviders'];

      return hospitalData.map((data) => deserialize<Hospital>(data)).toList();
    } else {
      return [];
    }
  }
}
