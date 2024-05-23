import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_scene/resources/app_resources.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Mq2 extends StatefulWidget {
  Mq2({super.key});

  @override
  State<Mq2> createState() => _Mq2State();
}

class _Mq2State extends State<Mq2> {
  AppColors _colors = AppColors();


  double gas=0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void mq2() async {
    final firebaseApp = await Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
        'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com/');

    // Reference to the 'temp' node
    DatabaseReference gasRef = rtdb.ref('gas');

    // Listen for changes to the 'temp' node
    gasRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        gas = double.parse(event.snapshot.value.toString());
      }
    });


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mq2();
    return StreamBuilder(
      stream: _firestore.collection('mq2').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('No data');
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        } else {
          final reads = snapshot.data!.docs;

          if (reads.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          final lastRead = reads.last;
          final double finalGas =
              lastRead.get('reading')?.toDouble() ?? 0.0;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.itemsBackground,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 20, spreadRadius: 2)
              ],
            ),
            width: double.infinity,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.gas_meter,
                        color: Colors.white,
                      ),
                      radius: 15,
                      backgroundColor: AppColors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'methane gas ',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: StepProgressIndicator(
                    totalSteps: 200,
                    currentStep: gas.toInt(),
                    size: 10,
                    padding: 0,
                    selectedColor: Colors.cyan,
                    unselectedColor: Colors.grey,
                    roundedEdges: Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.yellow, Colors.deepOrange],
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.grey],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
