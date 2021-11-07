part of 'news_cubit.dart';

abstract class StateTimerCubit {}

class TimerInitial extends StateTimerCubit {
  final String waitTime;
  final double percent;

  TimerInitial(this.waitTime, this.percent);
}

class TimerPauseState extends StateTimerCubit{
  final String currentTime;
  final double percent;

  TimerPauseState(this.currentTime, this.percent);
}

class TimerRunState extends StateTimerCubit {
  final String currentTime;
  final double percent;
  final int waitTime;

  TimerRunState(this.currentTime, this.percent, this.waitTime);
}

class TimerRunComplitly extends StateTimerCubit{}
