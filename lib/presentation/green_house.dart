import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:green_scene/presentation/widgets/dht11.dart';
import 'package:green_scene/presentation/widgets/mq2.dart';
import 'package:green_scene/presentation/widgets/soil_sensor.dart';
import 'package:green_scene/resources/app_colors.dart';
import 'package:green_scene/resources/app_resources.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class GreenHouse extends StatefulWidget {
  GreenHouse({super.key});

  @override
  State<GreenHouse> createState() => _GreenHouseState();
}

class _GreenHouseState extends State<GreenHouse> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
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

  DatabaseReference ref = FirebaseDatabase.instance.ref("door");
  double gasValue = 0;

  AppColors _colors = AppColors();
  bool pump = false;
  bool Door = false;
  double moistPercentage = 60;

  void updateDoor(String state) async {
    print('a777777777777777777777777777777777777777777777777');
    DatabaseReference ref = FirebaseDatabase.instance.ref();

// Only update the name, leave the age and address!
    await ref.update({
      "door": state,
    });
  }

  void updatePump(String state) async {
    print('aadas');
    DatabaseReference ref = FirebaseDatabase.instance.ref();

// Only update the name, leave the age and address!
    await ref.update({
      "pump": state,
    });
  }

  List cardIcons = [
    Icons.air,
    Icons.door_back_door_outlined,
  ];
  List cardLabel = [
    'Pump',
    'Door',
  ];

  @override
  Widget build(BuildContext context) {
    update();
    List cardColor = [
      _colors.purple,
      _colors.red,
      _colors.yellow,
      _colors.blue,
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Dht11(),
            Mq2(),
            SoilSensor(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 120,
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: Colors.white,
                            size: 35,
                          ),
                          Switch(
                              value: pump,
                              activeColor: cardColor[0],
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white,
                              onChanged: (value) => setState(() {
                                    pump = value;
                                    if (value == true) {
                                      updatePump('on');
                                    } else {
                                      updatePump('off');
                                    }
                                  }))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        cardLabel[0],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: cardColor[0],
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(5),
                ),
                Container(
                  height: 120,
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.door_back_door_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          Switch(
                              value: Door,
                              activeColor: cardColor[1],
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white,
                              onChanged: (value) => setState(() {
                                    Door = value;
                                    if (value == true) {
                                      updateDoor('on');
                                    } else {
                                      updateDoor('off');
                                    }
                                  }))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        cardLabel[1],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: cardColor[1],
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(5),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
