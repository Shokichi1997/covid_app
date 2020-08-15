import 'package:equatable/equatable.dart';
import 'package:rx/core.dart';

abstract class BaseObservableUseCase<OUT_PUT, Params> {
  Observable<OUT_PUT> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
