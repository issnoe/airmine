import 'package:flutter/material.dart';
import 'package:airmine/themes/colors.dart';
import 'package:location/location.dart';

import 'package:airmine/providers/location.dart';
import 'package:airmine/providers/aqi.dart';
import 'package:airmine/ScreenTop.dart';
import 'package:airmine/ScreenBottom.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AirMine',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  Location location = Location();
  String address;
  Map<String, dynamic> aqiData;

  reloadData() async {
    try {
      setState(() {
        address = null;
        aqiData = null;
      });
      location.getLocation().then((result) {
        locationGeocode(result).then((name) {
          setState(() {
            address = name;
          });
        });
        aqiProvider(result).then((aqi) {
          print(aqi.toString());
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
  void initState() {
    super.initState();
    reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ScreenTop(
              address: address,
              aqiData: aqiData,
              reloadData: reloadData,
            ),
            ScreenBottom(aqiData: aqiData),
          ],
        ),
      ),
    );
  }
}
