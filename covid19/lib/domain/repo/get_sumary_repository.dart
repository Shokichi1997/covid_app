import 'package:covid19/domain/entity/summary_entity.dart';
import 'package:rx/core.dart';

abstract class GetSummaryRepository {
  Observable<SummaryEntity> getSummary();
}