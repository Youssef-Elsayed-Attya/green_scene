import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_scene/resources/app_colors.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math';

class Dht11 extends StatefulWidget {
  Dht11({super.key});

  @override
  State<Dht11> createState() => _Dht11State();
}

class _Dht11State extends State<Dht11> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  int _counter = 0;
  late DatabaseReference _counterRef;
  late DatabaseReference _messagesRef;
  late StreamSubscription<DatabaseEvent> _counterSubscription;
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  bool _anchorToBottom = false;

  String _kTestKey = 'Hello';
  String _kTestValue = 'world!';
  FirebaseException? _error;
  bool initialized = false;
  double finalTemperature = 0;
  double finalHumidity = 0;

  @override
  void initState() {
    init();
    update();
    super.initState();
  }

  void update() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

    await ref.set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }

  Future<void> init() async {
    _counterRef = FirebaseDatabase.instance.ref(
        'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com/');

    final database = FirebaseDatabase.instance;

    _messagesRef = database.ref('messages');

    database.setLoggingEnabled(false);

    // if (!kIsWeb) {
    //   database.setPersistenceEnabled(true);
    //   database.setPersistenceCacheSizeBytes(10000000);
    // }
    //
    // if (!kIsWeb) {
    //   await _counterRef.keepSynced(true);
    // }

    setState(() {
      initialized = true;
    });

    try {
      final counterSnapshot = await _counterRef.get();

      print(
        'Connected to directly configured database and read '
        '${counterSnapshot.value}',
      );
    } catch (err) {
      print(err);
    }

    _counterSubscription = _counterRef.onValue.listen(
      (DatabaseEvent event) {
        setState(() {
          _error = null;
          _counter = (event.snapshot.value ?? 0) as int;
        });
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        setState(() {
          _error = error;
        });
      },
    );

    final messagesQuery = _messagesRef.limitToLast(10);

    _messagesSubscription = messagesQuery.onChildAdded.listen(
      (DatabaseEvent event) {
        print('Child added: ${event.snapshot.value}');
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        print('Error: ${error.code} ${error.message}');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> _increment() async {
    await _counterRef.set(ServerValue.increment(1));

    await _messagesRef
        .push()
        .set(<String, String>{_kTestKey: '$_kTestValue $_counter'});
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  late String door;

  List<Map<dynamic, dynamic>> _dataList = [];

  final AppColors _colors = AppColors();

  void listenToTempAndHum() async {
    final firebaseApp = await Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com/');

    // Reference to the 'temp' node
    DatabaseReference tempRef = rtdb.ref('temp');
    DatabaseReference humRef = rtdb.ref('hum');

    // Listen for changes to the 'temp' node
    tempRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        finalTemperature = double.parse(event.snapshot.value.toString());
      }
    });
    humRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        finalHumidity = double.parse(event.snapshot.value.toString());
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference _door = FirebaseDatabase.instance.ref().child('door');
    listenToTempAndHum();

    return StreamBuilder(
      stream: _firestore.collection('dht11').orderBy('timestamp').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
          // final double finalHumidity =
          //     lastRead.get('humidity')?.toDouble() ?? 0.0;
          // final double finalTemperature =
          //     lastRead.get('temperature')?.toDouble() ?? 0.0;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
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
                          'Humidity & Temperature  ',
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
                            color: Colors.black12,
                            blurRadius: 20,
                            spreadRadius: 2)
                      ],
                    ),
                    width: double.infinity,
                    height: 180,
                  ),
                  Positioned(
                    bottom: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          child: Center(
                            child: Text(
                              '$finalTemperature°',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          totalSteps: 50,
                          currentStep: finalTemperature.toInt(),
                          stepSize: 20,
                          selectedColor: Colors.red,
                          unselectedColor: Colors.purple[400],
                          padding: pi / 80,
                          width: 120,
                          height: 120,
                          startingAngle: -pi * 2 / 3,
                          arcSize: pi * 2 / 3 * 2,
                          gradientColor: LinearGradient(
                            colors: [Colors.red, Colors.purple.shade600],
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        CircularStepProgressIndicator(
                          child: Center(
                            child: Text(
                              '$finalHumidity°',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          totalSteps: 100,
                          currentStep: finalHumidity.toInt(),
                          stepSize: 10,
                          selectedColor: Colors.greenAccent,
                          unselectedColor: Colors.grey[200],
                          padding: 0,
                          width: 120,
                          height: 120,
                          selectedStepSize: 15,
                          roundedCap: (_, __) => true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
