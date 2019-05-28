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
      bottomNavigationBar: CustomAppBar(),
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

class PageX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Products',
                  icon: Icon(Icons.list),
                ),
                Tab(
                  text: 'Details',
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Text('hola mundo'),
              Text('hola mundo 2'),
            ],
          )),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
