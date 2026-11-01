import 'dart:convert';

import 'package:postcodes/models/place.dart';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  final List<Place> results;
  final double generationtimeMs;

  SearchResponse({required this.results, required this.generationtimeMs});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    results: json["results"] == null
        ? []
        : List<Place>.from(json["results"]!.map((x) => Place.fromJson(x))),
    generationtimeMs: json["generationtime_ms"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "generationtime_ms": generationtimeMs,
  };
}
