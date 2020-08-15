import 'dart:convert';

import 'country_entity.dart';
import 'global_entity.dart';

class SummaryEntity {
  SummaryEntity({
    this.global,
    this.countries,
  });

  GlobalEntity global;
  List<CountryEntity> countries;

  factory SummaryEntity.fromJson(String str) => SummaryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SummaryEntity.fromMap(Map<String, dynamic> json) => SummaryEntity(
        global: json["Global"] == null ? null : GlobalEntity.fromMap(json["Global"]),
        countries: json["Countries"] == null
            ? null
            : List<CountryEntity>.from(json["Countries"].map((x) => CountryEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Global": global == null ? null : global.toMap(),
        "Countries": countries == null ? null : List<dynamic>.from(countries.map((x) => x.toMap())),
      };
}
