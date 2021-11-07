import 'dart:async';

import 'package:flutter/material.dart';

class StateInheritedTimerPage extends InheritedWidget {
  final int waitTimeInSecInh;

  const StateInheritedTimerPage({
    Key? key,
     required Widget child,
     required this.waitTimeInSecInh,
     })
   : super(key: key, child: child);

  @override
  bool updateShouldNotify(StateInheritedTimerPage oldWidget) =>
    oldWidget.waitTimeInSecInh != waitTimeInSecInh;

}



class StateTimerPageInh extends StatefulWidget {
  final int waitTimeInSec;


  const StateTimerPageInh({Key? key, required this.waitTimeInSec})
   : super(key: key);

  @override
  _StateTimerPageState createState() => _StateTimerPageState();
}

class _StateTimerPageState extends State<StateTimerPageInh> {
  Timer? _timer;
  late int _waitTime;
  var _percent = 1.0;
  var isStart = false;
  var timeStr = '05:00';

 // _StateTimerPageState(timeStr, required this.percent);

  @override
  void initState() {
    super.initState();
    _waitTime = widget.waitTimeInSec;
    _calculationTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void start(BuildContext context){
    if(_waitTime > 0){
      setState(() {
        isStart = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
        _waitTime -= 1;
        _calculationTime();
        if (_waitTime <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Finish')));
          pause();
        }
      });
    }
  }

  void restart(){
    _waitTime = widget.waitTimeInSec;
    _calculationTime();
  }

  void pause(){
    _timer?.cancel();
    setState(() {
      isStart = false;
    });
  }

  void _calculationTime(){
    var minuteStr = (_waitTime ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_waitTime % 60).toString().padLeft(2, '0');
    setState(() {
      _percent = _waitTime / widget.waitTimeInSec;
      timeStr = '$minuteStr:$secondStr';
    });

  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final inher = context
      .dependOnInheritedWidgetOfExactType<StateInheritedTimerPage>()
      ?.waitTimeInSecInh ??
    0;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.height * 0.1,
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: () {
                restart();
              },
              child: const Icon(Icons.restart_alt),
            )
          ),
          StateInheritedTimerPage(
            waitTimeInSecInh: _waitTime,
            child: StatelessTimerPage(percent: _percent, timeStr: timeStr),
          ),
          Container(
            height: size.height * 0.1,
            width: size.height * 0.1,
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: () {
                isStart ? pause() : start(context);
                },
              child: isStart? const Icon(Icons.pause): const Icon(Icons.play_arrow),
            )
          ),
        ],
      ),
    );
  }
}




class StatelessTimerPage extends StatelessWidget {
  var percent;
  var timeStr;
  

  StatelessTimerPage({Key? key, required this.percent, required this.timeStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Stack(
      alignment: Alignment.center,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.height * 0.1,
            margin: const EdgeInsets.all(10),
            child: CircularProgressIndicator(
              value: percent,
              backgroundColor: Colors.red[800],
              strokeWidth: 8,
            )
          ),
          Positioned(
            child: Text(timeStr,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            )
          )
        ],
    );
  }
}