library model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'model.g.dart';

/// Code generation utility for JSON and serialization.
/// 
/// References:
/// * <https://github.com/google/built_value.dart>
/// * <https://flutter.dev/docs/development/data-and-backend/json>

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
  @nullable
  String get countryCodes;

  factory News([Function(NewsBuilder) updates]) = _$News;
  News._();
}

abstract class StatsCounter implements Built<StatsCounter, StatsCounterBuilder> {
  static Serializer<StatsCounter> get serializer => _$statsCounterSerializer;

  @nullable
  String get country;

  @BuiltValueField(wireName: 'num_confirm')
  int get numConfirm;

  @BuiltValueField(wireName: 'num_dead')
  int get numDead;

  @BuiltValueField(wireName: 'num_heal')
  int get numHeal;

  @nullable
  @BuiltValueField(wireName: 'created')
  String get created;

  factory StatsCounter([Function(StatsCounterBuilder) updates]) = _$StatsCounter;
  StatsCounter._();
}

abstract class Hospital implements Built<Hospital, HospitalBuilder> {
  static Serializer<Hospital> get serializer => _$hospitalSerializer;

  int get id;
  String get name;
  String get description;
  String get address;
  String get city;
  String get state;
  String get country;
  String get telNo;
  @nullable
  String get lat;
  @nullable
  String get long;
  @nullable
  String get addedBy;
  @nullable
  String get source;
  @nullable
  String get officialAdvisory;

  factory Hospital([Function(HospitalBuilder) updates]) = _$Hospital;
  Hospital._();
}

abstract class TravelAlert implements Built<TravelAlert, TravelAlertBuilder> {
  static Serializer<TravelAlert> get serializer => _$travelAlertSerializer;

  String get countryCode;
  String get countryName;
  String get publishedDate;
  String get alertMessage;
  
  factory TravelAlert([Function(TravelAlertBuilder) updates]) = _$TravelAlert;
  TravelAlert._();
}
