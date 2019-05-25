import 'package:airmine/widgets/radial_progress.dart';
import 'package:airmine/themes/colors.dart';
import 'package:airmine/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:airmine/providers/location.dart';
import 'package:airmine/providers/aqi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'AirMine',
      theme: appTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Location location = Location();
  String address;
  Map<String, dynamic> aqiData;
  var aqiObject = {};

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    try {
      location.getLocation().then((result) {
        locationGeocode(result).then((name) {
          setState(() {
            address = name;
          });
        });
        aqiProvider(result).then((aqi) {
          setState(() {
            aqiData = aqi;
          });
        });
      });
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        const error = 'Permission denied';
        print(error);
      }
    }
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  TopBar(),
                  Positioned(
                      top: 60.0,
                      left: 0.0,
                      right: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            SizedBox(width: 1),
                            Text(
                              '$address',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              RadialProgress(
                aqiNumber: aqiData['aqi'].toString(),
                aqiStatus: aqiData['state']['status'],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onIconPressed() {
    animationStatus
        ? _iconAnimationController.reverse()
        : _iconAnimationController.forward();
  }

  bool get animationStatus {
    final AnimationStatus status = _iconAnimationController.status;
    return status == AnimationStatus.completed;
  }
}
