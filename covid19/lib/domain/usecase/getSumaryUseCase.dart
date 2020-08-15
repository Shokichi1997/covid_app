import 'package:covid19/base/usecase.dart';
import 'package:covid19/domain/entity/summary_entity.dart';
import 'package:covid19/impl/get_summary_repository_impl.dart';
import 'package:rx/core.dart';

class GetSummaryUseCase extends BaseObservableUseCase<SummaryEntity, NoParams>{
  final _summaryRepository = GetSummaryRepositoryImpl();

  @override
  Observable<SummaryEntity> call(NoParams params) {
    return _summaryRepository.getSummary();
  }
}