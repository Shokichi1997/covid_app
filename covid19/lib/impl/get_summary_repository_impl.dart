import 'package:covid19/domain/entity/summary_entity.dart';
import 'package:covid19/domain/repo/get_sumary_repository.dart';
import 'package:dio/dio.dart';
import 'package:rx/core.dart';
import 'package:rx/converters.dart';
import 'package:rx/operators.dart';

class GetSummaryRepositoryImpl implements GetSummaryRepository {
  final Dio _dio = Dio();

  @override
  Observable<SummaryEntity> getSummary() {
    return _dio.get('https://api.covid19api.com/summary').toObservable().map((res) {
      return SummaryEntity.fromMap(res.data);
    });
  }
}
