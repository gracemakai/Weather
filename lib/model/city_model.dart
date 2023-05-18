// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

class CityModel {
  int? country;
  List<City>? cities;

  CityModel({
    this.country,
    this.cities,
  });

  factory CityModel.fromRawJson(String str) => CityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    country: json["country"],
    cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
  };
}

class City {
  int? id;
  String? name;

  City({
    this.id,
    this.name,
  });

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
