library search_response;

import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mobile_code_challenge_solution/core/models/repository/repository.dart';

import '../serializers.dart';

part 'search_response.g.dart';

abstract class SearchResponse
    implements Built<SearchResponse, SearchResponseBuilder> {
  factory SearchResponse([void Function(SearchResponseBuilder b) updates]) =
      _$SearchResponse;

  SearchResponse._();

  @BuiltValueField(wireName: 'total_count')
  int get totalCount;

  BuiltList<Repository> get items;

  static FutureOr<SearchResponse> fromJson(dynamic obj) {
    return obj != null
        ? serializers.deserializeWith(
            SearchResponse.serializer, json.decode(utf8.decode(obj)))
        : null;
  }

  static Serializer<SearchResponse> get serializer =>
      _$searchResponseSerializer;
}
