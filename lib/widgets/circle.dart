import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:airmine/providers/aqi.dart';

abstract class Page extends StatelessWidget {
  const Page(this.leading, this.title);

  final Widget leading;
  final String title;
}

class PlaceCircleBody extends StatefulWidget {
  var locationState;
  var aqiMapData;
  PlaceCircleBody({this.locationState, this.aqiMapData});

  @override
  State<StatefulWidget> createState() => PlaceCircleBodyState();
}

class PlaceCircleBodyState extends State<PlaceCircleBody> {
  PlaceCircleBodyState();

  GoogleMapController controller;
  Map<CircleId, Circle> circles = <CircleId, Circle>{};
  int _circleIdCounter = 1;
  CircleId selectedCircle;

  // Values when toggling circle color
  int fillColorsIndex = 0;
  int strokeColorsIndex = 0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];

  // Values when toggling circle stroke width
  int widthsIndex = 0;
  List<int> widths = <int>[10, 20, 5];

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  @override
  void initState() {
    print('aqiMapData');
    print(widget.aqiMapData.length);

    for (var x = 0; x < widget.aqiMapData.length; x++) {
      double colindex = 40;
      // print(widget.aqiMapData[x]);
      // double s = double.tryParse(widget.aqiMapData[x]['aqi'].toString());
      // if (s != null) {
      //   colindex = widget.aqiMapData[x]['aqi'];
      //   print(colindex);
      // }
      Color col = colorize(colindex, 'aqi');
      _add(
        widget.aqiMapData[x]['lat'],
        widget.aqiMapData[x]['lon'],
        widget.aqiMapData[x]['uid'],
        col,
      );
    }

    // _add(
    //   widget.locationState['latitude'],
    //   widget.locationState['longitude'],
    //   '21z',
    //   Colors.green,
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCircleTapped(CircleId circleId) {
    setState(() {
      selectedCircle = circleId;
    });
  }

  void _remove() {
    setState(() {
      if (circles.containsKey(selectedCircle)) {
        circles.remove(selectedCircle);
      }
      selectedCircle = null;
    });
  }

  void _add(lat, lon, id, Color col) {
    final int circleCount = circles.length;

    if (circleCount == 12) {
      return;
    }

    final String circleIdVal = 'circle_id_$id';

    final CircleId circleId = CircleId(circleIdVal);

    final Circle circle = Circle(
      circleId: circleId,
      consumeTapEvents: false,
      strokeColor: col,
      // fillColor: col,
      strokeWidth: 47,
      center: LatLng(lat, lon),
      radius: 3990,
    );

    setState(() {
      circles[circleId] = circle;
    });
  }

  void _toggleVisible() {
    final Circle circle = circles[selectedCircle];
    setState(() {
      circles[selectedCircle] = circle.copyWith(
        visibleParam: !circle.visible,
      );
    });
  }

  void _changeFillColor() {
    final Circle circle = circles[selectedCircle];
    setState(() {
      circles[selectedCircle] = circle.copyWith(
        fillColorParam: colors[++fillColorsIndex % colors.length],
      );
    });
  }

  void _changeStrokeColor() {
    final Circle circle = circles[selectedCircle];
    setState(() {
      circles[selectedCircle] = circle.copyWith(
        strokeColorParam: colors[++strokeColorsIndex % colors.length],
      );
    });
  }

  void _changeStrokeWidth() {
    final Circle circle = circles[selectedCircle];
    setState(() {
      circles[selectedCircle] = circle.copyWith(
        strokeWidthParam: widths[++widthsIndex % widths.length],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.locationState['latitude'],
            widget.locationState['longitude'],
          ),
          zoom: 7.9,
        ),
        circles: Set<Circle>.of(circles.values),
        onMapCreated: _onMapCreated,
      ),
    );
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     Center(
    //       child: SizedBox(
    //         height: 400.0,
    //         child: GoogleMap(
    //           initialCameraPosition: CameraPosition(
    //             target: LatLng(
    //               widget.locationState['latitude'],
    //               widget.locationState['longitude'],
    //             ),
    //             zoom: 8.9,
    //           ),
    //           circles: Set<Circle>.of(circles.values),
    //           onMapCreated: _onMapCreated,
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: SingleChildScrollView(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             Row(
    //               children: <Widget>[
    //                 Column(
    //                   children: <Widget>[
    //                     FlatButton(
    //                       child: const Text('add'),
    //                       onPressed: () {
    //                         _add(
    //                           widget.locationState['latitude'],
    //                           widget.locationState['longitude'],
    //                         );
    //                       },
    //                     ),
    //                     FlatButton(
    //                       child: const Text('remove'),
    //                       onPressed: (selectedCircle == null) ? null : _remove,
    //                     ),
    //                     FlatButton(
    //                       child: const Text('toggle visible'),
    //                       onPressed:
    //                           (selectedCircle == null) ? null : _toggleVisible,
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: <Widget>[
    //                     FlatButton(
    //                       child: const Text('change stroke width'),
    //                       onPressed: (selectedCircle == null)
    //                           ? null
    //                           : _changeStrokeWidth,
    //                     ),
    //                     FlatButton(
    //                       child: const Text('change stroke color'),
    //                       onPressed: (selectedCircle == null)
    //                           ? null
    //                           : _changeStrokeColor,
    //                     ),
    //                     FlatButton(
    //                       child: const Text('change fill color'),
    //                       onPressed: (selectedCircle == null)
    //                           ? null
    //                           : _changeFillColor,
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  LatLng _createCenter(lat, lng) {
    final double offset = _circleIdCounter.ceilToDouble();
    return _createLatLng(lat + offset * 0.2, lng);
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}
