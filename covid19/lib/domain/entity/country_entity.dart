import 'dart:convert';

class CountryEntity {
  CountryEntity({
    this.country,
    this.countryCode,
    this.slug,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
  });

  String country;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  DateTime date;

  factory CountryEntity.fromJson(String str) => CountryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountryEntity.fromMap(Map<String, dynamic> json) =>
      CountryEntity(
        country: json["Country"] == null ? null : json["Country"],
        countryCode: json["CountryCode"] == null ? null : json["CountryCode"],
        slug: json["Slug"] == null ? null : json["Slug"],
        newConfirmed: json["NewConfirmed"] == null ? null : json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"] == null ? null : json["TotalConfirmed"],
        newDeaths: json["NewDeaths"] == null ? null : json["NewDeaths"],
        totalDeaths: json["TotalDeaths"] == null ? null : json["TotalDeaths"],
        newRecovered: json["NewRecovered"] == null ? null : json["NewRecovered"],
        totalRecovered: json["TotalRecovered"] == null ? null : json["TotalRecovered"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toMap() =>
      {
        "Country": country == null ? null : country,
        "CountryCode": countryCode == null ? null : countryCode,
        "Slug": slug == null ? null : slug,
        "NewConfirmed": newConfirmed == null ? null : newConfirmed,
        "TotalConfirmed": totalConfirmed == null ? null : totalConfirmed,
        "NewDeaths": newDeaths == null ? null : newDeaths,
        "TotalDeaths": totalDeaths == null ? null : totalDeaths,
        "NewRecovered": newRecovered == null ? null : newRecovered,
        "TotalRecovered": totalRecovered == null ? null : totalRecovered,
        "Date": date == null ? null : date.toIso8601String(),
      };
}