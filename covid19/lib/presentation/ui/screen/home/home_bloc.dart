import 'package:covid19/base/usecase.dart';
import 'package:covid19/domain/usecase/getSumaryUseCase.dart';
import 'package:covid19/presentation/modal/summary.dart';
import 'package:flutter/material.dart';
import 'package:rx/core.dart';

enum HomeStatus { SUCCESSFUL, ERROR, IDLE }

class HomeBloc extends ChangeNotifier {
  final _getSummaryUseCase = GetSummaryUseCase();
  Summary summary;
  HomeStatus status = HomeStatus.IDLE;

  void getSummary() {
    status = HomeStatus.IDLE;
    _getSummaryUseCase(NoParams()).subscribe(Observer(next: (summaryEntity) {
      summary = SummaryEntityMapper().mapToModal(summaryEntity);
      status = HomeStatus.SUCCESSFUL;
      notifyListeners();
    }, error: (e, [st]) {
      status = HomeStatus.ERROR;
      print(e);
      notifyListeners();
    }));
  }
}
