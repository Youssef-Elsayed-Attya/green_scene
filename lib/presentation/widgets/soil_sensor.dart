import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_scene/resources/app_resources.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SoilSensor extends StatefulWidget {
  SoilSensor({super.key});

  @override
  State<SoilSensor> createState() => _SoilSensorState();
}

class _SoilSensorState extends State<SoilSensor> {
  AppColors _colors = AppColors();

  double soil=0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void soilSensor() async {
    final firebaseApp = await Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
        'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com/');

    // Reference to the 'temp' node
    DatabaseReference soilRef = rtdb.ref('value');

    // Listen for changes to the 'temp' node
    soilRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        double x = double.parse(event.snapshot.value.toString());
        x=1370-x;
        soil=((x-370)/630)*100;
      }
    });


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    soilSensor();
    return StreamBuilder(
      stream: _firestore.collection('soil').orderBy('timestamp').snapshots(),
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
          double finalMoisture =
              lastRead.get('reading')?.toDouble() ?? 0.0;
          finalMoisture=1370-finalMoisture;
          finalMoisture=((finalMoisture-370)/630)*100;

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.sunny,
                        color: Colors.white,
                      ),
                      radius: 15,
                      backgroundColor: AppColors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Soil Moisture Percentage ',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
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
                height: 180,
              ),
              Positioned(
                bottom: 35,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: LiquidCircularProgressIndicator(
                    value: (soil / 100),
                    // Defaults to 0.5.
                    valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                    // Defaults to the current Theme's accentColor.
                    backgroundColor: Colors.white,
                    // Defaults to the current Theme's backgroundColor.
                    borderColor: Colors.lightBlue,
                    borderWidth: 3.0,
                    direction: Axis.vertical,
                    // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                    center: Text("${soil.floor()} %"),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
