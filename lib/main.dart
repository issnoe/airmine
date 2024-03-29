import 'package:flutter/material.dart';
import 'package:airmine/themes/colors.dart';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:airmine/providers/location.dart';
import 'package:airmine/providers/aqi.dart';
import 'package:airmine/ScreenTop.dart';
import 'package:airmine/ScreenBottom.dart';
import 'package:airmine/widgets/mapa.dart';
import 'package:airmine/widgets/circle.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> main() async {
//   final FirebaseApp app = await FirebaseApp.configure(
//     name: 'test',
//     options: const FirebaseOptions(
//       googleAppID: '1:598639561177:android:a1e03512bf952475',
//       apiKey: 'AIzaSyCWR-ZcKgMzeuf1kx6dn7q9pat-QEOhtd8',
//       projectID: 'airmine-42cb4',
//     ),
//   );
//   final Firestore firestore = Firestore(app: app);
//   await firestore.settings(timestampsInSnapshotsEnabled: true);

//   runApp(MaterialApp(title: 'Firestore Example', home: Text('j')));
// }
//import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// Future<void> main() async {
//   final FirebaseApp app = await FirebaseApp.configure(
//       name: 'train-firebase',
//       options: const FirebaseOptions(
//         googleAppID: '1:497519332859:android:704022a40bc18170',
//         apiKey: 'AIzaSyAdVA1xgsmicRme7A1BwQ4bjcaBUf7mNOg',
//         databaseURL: 'https://train-firebase-b5e52.firebaseio.com',
//       ));

//   runApp(MaterialApp(
//     home: MyApp(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

//void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps Demo',
//       home: MapSample(),
//     );
//   }
// }

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

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Location location = Location();
  String address;
  TabController tabcontroller;
  Map<String, dynamic> aqiData;
  var aqiMapData;
  var locationState;

  List<Map<String, dynamic>> notifications = [
    {
      "createAT": "2019-05-29T00:34:26.979Z",
      "description": "Contingencia ambiental",
      "image":
          "http://propiedades.com/blog/wp-content/uploads/2016/04/emisiones-transporte.png",
      "type": "ads"
    }
  ];

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
            locationState = result;
          });
        });
        aqiProvider(result).then((aqi) {
          // print(aqi.toString());
          setState(() {
            aqiData = aqi;
          });
        });
        aqiMapProvider(result).then((aqi) {
          print(aqi.toString());
          setState(() {
            aqiMapData = aqi;
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
    /*
    getNotifications().then((res_notifications) {
      res_notifications.forEach((k, v) {
        setState(() {
          notifications.add({
            "createAT": "2019-05-29T00:34:26.979Z",
            "description": "Contingencia ambiental",
            "image":
                "https://firebasestorage.googleapis.com/v0/b/airmine-42cb4.appspot.com/o/contingencia.jpg?alt=media&token=f8712a5b-d046-4fda-93fd-eb9c5d54074d",
            "type": "ads"
          });
        });
      });
    });*/
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
          PlaceCircleBody(locationState: locationState, aqiMapData: aqiMapData),
          ScreenNotifications(notifications: notifications),
          Screens(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        elevation: 10.0,
        child: TabBar(
          controller: tabcontroller,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.cloud)),
            Tab(icon: Icon(Icons.map)),
            Tab(icon: Icon(Icons.notifications)),
            Tab(icon: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}

class Screens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen();
  }
}

class ScreenNotifications extends StatelessWidget {
  List<Map<String, dynamic>> notifications;
  ScreenNotifications({this.notifications}) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: notifications.length > 0
          ? new ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (BuildContext ctxt, int index) {
                print(notifications[index]);
                return Notification(notifications[index]);
              })
          : Container(),
    );
  }
}

class NotificationModel {
  String type;
  String description;
  String image;
  String createAt;
  NotificationModel(this.type, this.description, this.image, this.createAt);
}

class Notification extends StatelessWidget {
  var data;
  Notification(this.data) {}
  @override
  Widget build(BuildContext context) {
    //return Text('hj');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Text('${data['type']}'),
          SizedBox(
            height: 100,
          ),
          Container(
              width: 500,
              child: CachedNetworkImage(
                imageUrl:
                    'http://via.placeholder.com/350x150', //'${data['image']}',
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
                // placeholder: Center(child: CircularProgressIndicator()),
              )),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<SettingsScreen> {
  bool _value1 = false;
  bool _value2 = false;

  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ajustes'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Incognito',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Configure las notificaciones',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              new SwitchListTile(
                value: _value1,
                onChanged: _onChanged1,
                title: new Text('Notificaciones por hora',
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black)),
              ),
              new SwitchListTile(
                value: _value2,
                onChanged: _onChanged2,
                title: new Text('Notificaciones contingencias',
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
