import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<S,A,NE> extends Cubit<S>{
  BaseCubit(super.initialState);

  Future<void> doActions(A action);

  final StreamController<NE> _streamController = StreamController.broadcast();

  Stream<NE> get navigation => _streamController.stream;

  void emitNavigation(NE navigationAction){
    _streamController.add(navigationAction);
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }

}