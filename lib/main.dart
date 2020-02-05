import 'package:flutter/material.dart';
import 'package:airmine/themes/colors.dart';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:airmine/providers/location.dart';
import 'package:airmine/providers/aqi.dart';
import 'package:airmine/ScreenTop.dart';
import 'package:airmine/ScreenBottom.dart';
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
  List<Map<String, dynamic>> notifications;

  reloadData() async {
    try {
      setState(() {
        address = null;
        aqiData = null;
      });
      try {
        location.getLocation().then((result) {
          locationGeocode(result).then((name) {
            setState(() {
              address = name;
            });
          });
          aqiProvider(result).then((aqi) {
            // print(aqi.toString());
            setState(() {
              aqiData = aqi;
            });
          });
        });
      } catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          print('Permission denied');
        }
      }

      getNotifications().then((notifications) {
        print(notifications.toString());
        setState(() {
          notifications = notifications;
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
    return Text('hi');
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
    return Text('hj');
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
    //   child: Stack(
    //     children: <Widget>[
    //       Text('${data['type']}'),
    //       SizedBox(
    //         height: 100,
    //       ),
    //       Container(
    //           width: 500,
    //           child: CachedNetworkImage(
    //             imageUrl: '${data['image']}',
    //             fit: BoxFit.cover,
    //             fadeInDuration: Duration(milliseconds: 500),
    //             fadeInCurve: Curves.easeIn,
    //             // placeholder: Center(child: CircularProgressIndicator()),
    //           )),
    //     ],
    //   ),
    // );
  }
}
