import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/data.dart';



// class PtoviderTimerPage extends StatefulWidget {
//   final int waitTimeInSec;


//   const PtoviderTimerPage({Key? key, required this.waitTimeInSec})
//    : super(key: key);

//   @override
//   // _PtoviderTimerPage createState() => _PtoviderTimerPage();
// }

class PtoviderTimerPage extends StatelessWidget {

  final int waitTimeInSec;
  const PtoviderTimerPage({Key? key, required this.waitTimeInSec}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
          create: (BuildContext context) => Data(),
          builder: (context, child) => buildPage(context)        
    );
  }

  Widget buildPage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    Provider.of<Data>(context, listen: false).readWaitTimeInSec(waitTimeInSec);
    Provider.of<Data>(context, listen: false).calculationTime();

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
                      context.read<Data>().restart();
                    },
                    child: const Icon(Icons.restart_alt),
                  )
                ),
                Stack(
                  alignment: Alignment.center,
                    children: [
                      Container(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        margin: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          value: context.watch<Data>().getDataPercent,
                          backgroundColor: Colors.red[800],
                          strokeWidth: 8,
                        )
                      ),
                      Positioned(
                        child: Text(context.watch<Data>().getDataTimeStr,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        )
                      )
                    ],
                ),
                Container(
                  height: size.height * 0.1,
                  width: size.height * 0.1,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      Provider.of<Data>(context, listen: false).getDataIsRun 
                      ? Provider.of<Data>(context, listen: false).pause()
                      : Provider.of<Data>(context, listen: false).start(context);
                      },
                    child: context.watch<Data>().getDataIsRun
                    ? const Icon(Icons.pause)
                    : Icon(Icons.play_arrow),
                  )
                ),
              ],
            ),
          );
  }
}





// class StatelessTimerPage extends StatelessWidget {

//   const StatelessTimerPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
    
//     return 
    
//   }
// }


// class ProvTimePage extends StatelessWidget {

//   final prov = _PtoviderTimerPage();

//     ProvTimePage({Key? key}) : super(key: key);

//     @override
//     Widget build(BuildContext context) {
//       final size = MediaQuery.of(context).size;

//       return               Container(
//                 height: size.height * 0.1,
//                 width: size.height * 0.1,
//                 margin: const EdgeInsets.all(10),
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     prov.isStart ? prov.pause() : prov.start(context);
//                     },
//                   child: prov.isStart? const Icon(Icons.pause): const Icon(Icons.play_arrow),
//                 )
//               );
//     }

// }