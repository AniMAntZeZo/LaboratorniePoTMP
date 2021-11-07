import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:new_project_01/src/bloc_widget/bloc/timer_bloc.dart';

part 'news_state.dart';

class TimerCubit extends Cubit<StateTimerCubit> {
  Timer? _timer;
  final int _waitTimeInSec;
  int _currentWaitTimeInSec;
  double percent;
  String _timeStr;

  TimerCubit({required int waitTimeInSec})
      : _waitTimeInSec = waitTimeInSec,
        _currentWaitTimeInSec = waitTimeInSec,
        percent = 1,
        _timeStr = "${waitTimeInSec ~/ 60}".padLeft(2, '0') +":"+"${waitTimeInSec % 60}".padLeft(2, '0'),
        super(TimerInitial("${waitTimeInSec ~/ 60}".padLeft(2, '0') +":"+"${waitTimeInSec % 60}".padLeft(2, '0'), 1));



  Future<void> startTimer(BuildContext context) async{
  emit(TimerRunState(_timeStr, percent, _waitTimeInSec));
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
    _currentWaitTimeInSec -= 1;
    percent = await calculationPercent();
    _timeStr = await calculationTime();
    emit(TimerRunState(_timeStr, percent, _waitTimeInSec));
    if (_currentWaitTimeInSec < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Finish')));
      _currentWaitTimeInSec = _waitTimeInSec;
      percent = 1;
      _timeStr = await calculationTime();
      _timer?.cancel();
      emit(TimerRunComplitly());
      emit(TimerInitial(_timeStr, 1));
    }
  }
  );
  }

  Future<void> restartTimer() async {
    _currentWaitTimeInSec = _waitTimeInSec;
    percent = 1;
    _timeStr = await calculationTime();
    _timer?.cancel();
    emit(TimerRunState(_timeStr, percent, _waitTimeInSec));
  }


  Future<void> pauseTimer() async {
    _timer?.cancel();
    emit(TimerPauseState(_timeStr, percent));

  }

  Future<double> calculationPercent() async {
    var percent = _currentWaitTimeInSec / _waitTimeInSec;
    return (percent);
  }

  Future<String> calculationTime() async {
    var minuteStr = (_currentWaitTimeInSec ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_currentWaitTimeInSec % 60).toString().padLeft(2, '0');
    return ("$minuteStr:$secondStr");
}

}