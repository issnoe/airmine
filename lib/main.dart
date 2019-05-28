import 'package:flutter/material.dart';
import 'package:airmine/themes/colors.dart';
import 'package:location/location.dart';

import 'package:airmine/providers/location.dart';
import 'package:airmine/providers/aqi.dart';
import 'package:airmine/ScreenTop.dart';
import 'package:airmine/ScreenBottom.dart';
import 'package:airmine/widgets/customAppBar.dart';

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
      routes: {
        '/home': (BuildContext contex) => HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Location location = Location();
  String address;
  TabController tabcontroller;
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
    tabcontroller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabcontroller,
        children: <Widget>[
          SingleChildScrollView(
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
          Screens(),
          Screens(),
          Screens(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        elevation: 15.0,
        child: TabBar(
          controller: tabcontroller,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.cloud,
              ),
            ),
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.notifications),
            ),
            Tab(
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}

class Screens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('hi');
  }
}
