import 'dart:convert';
import 'package:covid19/domain/entity/global_entity.dart';
import 'package:covid19/domain/entity/summary_entity.dart';
import 'country.dart';
import 'entity_base_mapper.dart';

class Summary {
  Summary({
    this.global,
    this.countries,
  });

  GlobalEntity global;
  List<Country> countries;

  factory Summary.fromJson(String str) => Summary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Summary.fromMap(Map<String, dynamic> json) => Summary(
        global: json["Global"] == null ? null : GlobalEntity.fromMap(json["Global"]),
        countries:
            json["Countries"] == null ? null : List<Country>.from(json["Countries"].map((x) => Country.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Global": global == null ? null : global.toMap(),
        "Countries": countries == null ? null : List<dynamic>.from(countries.map((x) => x.toMap())),
      };
}

class SummaryEntityMapper extends BaseEntityMapper<SummaryEntity, Summary> {
  @override
  SummaryEntity mapToEntity(Summary modal) {
    return SummaryEntity(
      global: modal.global,
      countries: CountryEntityMapper().mapToEntities(modal.countries),
    );
  }

  @override
  Summary mapToModal(SummaryEntity entity) {
    return Summary(
      global: entity.global,
      countries: CountryEntityMapper().mapToModals(entity.countries),
    );
  }
}
