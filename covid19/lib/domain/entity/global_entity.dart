import 'dart:convert';

class GlobalEntity {
  GlobalEntity({
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
  });

  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  factory GlobalEntity.fromJson(String str) => GlobalEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GlobalEntity.fromMap(Map<String, dynamic> json) => GlobalEntity(
    newConfirmed: json["NewConfirmed"] == null ? null : json["NewConfirmed"],
    totalConfirmed: json["TotalConfirmed"] == null ? null : json["TotalConfirmed"],
    newDeaths: json["NewDeaths"] == null ? null : json["NewDeaths"],
    totalDeaths: json["TotalDeaths"] == null ? null : json["TotalDeaths"],
    newRecovered: json["NewRecovered"] == null ? null : json["NewRecovered"],
    totalRecovered: json["TotalRecovered"] == null ? null : json["TotalRecovered"],
  );

  Map<String, dynamic> toMap() => {
    "NewConfirmed": newConfirmed == null ? null : newConfirmed,
    "TotalConfirmed": totalConfirmed == null ? null : totalConfirmed,
    "NewDeaths": newDeaths == null ? null : newDeaths,
    "TotalDeaths": totalDeaths == null ? null : totalDeaths,
    "NewRecovered": newRecovered == null ? null : newRecovered,
    "TotalRecovered": totalRecovered == null ? null : totalRecovered,
  };
}