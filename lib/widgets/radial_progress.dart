import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double goalCompleted = 0.7;
  String aqiNumber = '?';
  String aqiStatus = '?';
  List<dynamic> listColors;
  RadialProgress({this.aqiNumber, this.aqiStatus, this.listColors});
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    //0 - 540
    _progressAnimation = Tween(begin: 0.0, end: 540.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 200.0,
        width: 200.0,
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: progressDegrees > 30 ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Column(
            children: <Widget>[
              Text(
                '${widget.aqiStatus}',
                style: TextStyle(fontSize: 24.0, letterSpacing: 1.5),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                height: 5.0,
                width: 80.0,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${widget.aqiNumber}',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'ÍNDICE',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue[300],
                    letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(
        progressInDegrees: progressDegrees,
        colors: widget.listColors,
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;
  List<Color> colors;

  RadialPainter({this.progressInDegrees, this.colors});

  //  Colors.red[900],
  //       Colors.orange,
  //       Colors.yellow,
  //       Colors.green,

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(colors: colors, begin: Alignment.centerLeft)
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(180),
      math.radians(progressInDegrees),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
