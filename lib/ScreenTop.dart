import 'package:flutter/material.dart';
import 'package:airmine/widgets/top_bar.dart';
import 'package:airmine/widgets/radial_progress.dart';

class ScreenTop extends StatefulWidget {
  String address;
  Map<String, dynamic> aqiData;
  Function reloadData;
  ScreenTop({this.address, this.aqiData, this.reloadData});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<ScreenTop>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                          Container(
                            child: widget.address != null
                                ? Text(
                                    '${widget.address}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ),
                          Spacer(),
                          InkWell(
                            child: Icon(
                              Icons.replay,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            onTap: () {
                              widget.reloadData();
                            },
                          )
                        ],
                      ),
                    ))
              ],
            ),
            Container(
              child: widget.aqiData != null
                  ? RadialProgress(
                      aqiNumber: widget.aqiData['aqi'].toString(),
                      aqiStatus: widget.aqiData['state']['status'],
                      listColors: widget.aqiData['state']['color'],
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ],
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
