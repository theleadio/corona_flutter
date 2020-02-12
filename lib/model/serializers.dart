library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'model.dart';

part 'serializers.g.dart';

/// Code generation utility for JSON and serialization.
///
/// References:
/// * <https://github.com/google/built_value.dart>
/// * <https://flutter.dev/docs/development/data-and-backend/json>

@SerializersFor([
  News,
  StatsCounter,
  Hospital,
  TravelAlert,
])
final Serializers serializers = _$serializers;

final Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

T deserialize<T>(dynamic value) => standardSerializers.deserializeWith<T>(
    standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) => BuiltList.from(
    value.map((value) => deserialize<T>(value)).toList(growable: false));
