import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/model/serializers.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

abstract class ApiProvider {
  Future<List<Article>> fetchArticles();
}

class RemoteRepository extends ApiProvider {
  Client client = Client();
  final String _baseUrl = 'http://www.coronatracker.com/news';

  Future<List<Article>> fetchArticles() async {
    final response = await client.get("$_baseUrl");

    if (response.statusCode == 200) {
      final Iterable articlesData = json.decode(response.body);
      return articlesData.map((data) => deserialize<Article>(data)).toList();
    } else {
      return null;
    }
  }
}
