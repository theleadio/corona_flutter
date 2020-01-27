library model;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'model.g.dart';

abstract class News implements Built<News, NewsBuilder> {
  static Serializer<News> get serializer => _$newsSerializer;

  int get nid;
  String get title;
  @nullable
  String get description;
  @nullable
  String get author;
  String get url;
  @nullable
  String get content;
  @nullable
  String get urlToImage;
  @nullable
  String get publishedAt;
  @nullable
  String get addedOn;

  factory News([Function(NewsBuilder) updates]) = _$News;
  News._();
}
