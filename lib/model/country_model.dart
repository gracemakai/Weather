// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

class CountryModel {
  int? id;
  String? name;
  String? shortName;

  CountryModel({
    this.id,
    this.name,
    this.shortName,
  });

  factory CountryModel.fromRawJson(String str) => CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"],
    name: json["name"],
    shortName: json["shortName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "shortName": shortName,
  };
}
