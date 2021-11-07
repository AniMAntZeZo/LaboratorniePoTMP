import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_cubit.dart';


class CubitTimerPage extends StatelessWidget {
  final int _waitTimeIbSec;
  const CubitTimerPage({Key? key,required int waitTimeInSec})
      :_waitTimeIbSec = waitTimeInSec,
      super(key: key,);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerCubit(waitTimeInSec: _waitTimeIbSec),
      child: const _CubitTimerPage(),
    );
  }
}

class _CubitTimerPage extends StatelessWidget {
  const _CubitTimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


      return BlocBuilder<TimerCubit, StateTimerCubit>(builder: (context, state) {

        if (state is TimerInitial) {
          return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                        margin: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          value: state.percent,
                          backgroundColor: Colors.red[800],
                          strokeWidth: 8,
                        )),
                    Positioned(
                        child: Text(
                          state.waitTime,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
                  Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                  onPressed: () => context.read<TimerCubit>().startTimer(context),
                  child: const Icon(Icons.play_arrow),

        )),
    ],
          )
          );
        }
        if (state is TimerRunState) {
          return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () => context.read<TimerCubit>().restartTimer(),
                    child: const Icon(Icons.replay),

                  )),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: size.height * 0.1,
                          width: size.width * 0.2,
                          margin: const EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            value: state.percent,
                            backgroundColor: Colors.red[800],
                            strokeWidth: 8,
                          )),
                      Positioned(
                          child: Text(
                            state.currentTime,
                            style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.center,
                          ))
                  ],
                ),
                Container(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    margin: const EdgeInsets.all(10),
                    child: FloatingActionButton(
                      onPressed: () => context.read<TimerCubit>().pauseTimer(),
                      child: const Icon(Icons.pause),

                    )),
            ],
          )
          );
        }
         if (state is TimerPauseState) {
          return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                        margin: const EdgeInsets.all(10),
                        child: FloatingActionButton(
                          onPressed: () => context.read<TimerCubit>().restartTimer(),
                          child: const Icon(Icons.replay),

                        )),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            height: size.height * 0.1,
                            width: size.width * 0.2,
                            margin: const EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              value: state.percent,
                              backgroundColor: Colors.red[800],
                              strokeWidth: 8,
                            )),
                        Positioned(
                            child: Text(
                              state.currentTime,
                              style:
                              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            ))
                ],
              ),
              Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () => context.read<TimerCubit>().startTimer(context),
                    child: const Icon(Icons.play_arrow),

                  )),
            ],
          )
          );
        }
         else {
           return Container();
         }

      }
      );
  }
}