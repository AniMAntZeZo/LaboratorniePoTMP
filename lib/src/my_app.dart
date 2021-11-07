import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bloc_widget/bloc_timer_page.dart';
import 'cubit/cubit_timer_page.dart';
import 'getx_widget/getx_timer_page.dart';
import 'inherited_widget/inherited_timer_page.dart';
import 'provider_widget/provider_timer_page.dart';
import 'stateful_widget/state_timer_page.dart';

const waitTime = 5;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override // Тут обёрнуто в гет
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Timer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late Widget _bodyWidget;

  /*static List<Widget> listTimerWidget = <Widget>[
    const StateTimerPage(waitTimeInSec: waitTime,),
    const BLoCTimerPage(waitTimeInSec: waitTime,),
    GetXTimerPaeg(waitTimeInSec: waitTime,)
  ];*/
@override
void initState() {
  super.initState();
  onItemTepped(selectedIndex);
}


Widget _buildCurrentWidget(int type) {
  switch (type) {
    case 0:
      return const StateTimerPage(waitTimeInSec: waitTime,);
    case 1:
      return const BLoCTimerPage(waitTimeInSec: waitTime,);
    case 2:
      return GetXTimerPaeg(waitTimeInSec: waitTime,);
    case 3:
      return const StateTimerPageInh(waitTimeInSec: waitTime,);
    case 4:
      return  PtoviderTimerPage(waitTimeInSec: waitTime);
    case 5:
      return const CubitTimerPage(waitTimeInSec: waitTime);
    default:
      throw ArgumentError();
  }
}

  void onItemTepped(int index){
    setState(() {
      selectedIndex = index;
      _bodyWidget = _buildCurrentWidget(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:_bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red[800],
        onTap: onItemTepped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.youtube_searched_for), label: 'Stateful'),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab_rounded), label: 'BLoc'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chair), label: 'GetX'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree), label: 'Inherit'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant_navigation), label: 'Provider'),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square), label: 'Cubit'),
        ],
      ),
    );
  }
}