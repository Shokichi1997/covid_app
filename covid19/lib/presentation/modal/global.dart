import 'dart:convert';

import 'package:covid19/domain/entity/global_entity.dart';

import 'entity_base_mapper.dart';

class Global {
  Global({
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

  factory Global.fromJson(String str) => Global.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Global.fromMap(Map<String, dynamic> json) => Global(
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

class GlobalEntityMapper extends BaseEntityMapper<GlobalEntity, Global> {
  @override
  GlobalEntity mapToEntity(Global modal) {
    return GlobalEntity(
      newConfirmed: modal.newConfirmed,
      totalConfirmed: modal.totalConfirmed,
      newDeaths: modal.newDeaths,
      totalDeaths: modal.totalDeaths,
      newRecovered: modal.newRecovered,
      totalRecovered: modal.totalRecovered,
    );
  }

  @override
  Global mapToModal(GlobalEntity entity) {
    return Global(
      newConfirmed: entity.newConfirmed,
      totalConfirmed: entity.totalConfirmed,
      newDeaths: entity.newDeaths,
      totalDeaths: entity.totalDeaths,
      newRecovered: entity.newRecovered,
      totalRecovered: entity.totalRecovered,
    );
  }
}
