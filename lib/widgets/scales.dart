import 'package:flutter/material.dart';

class Scales extends StatelessWidget {
  var scalesList = [
    {
      "color": Colors.green,
      "description": 'Cualquier actividad al aire libre',
      "level": 'Bueno',
      "range": '0 - 50',
    },
    {
      "color": Colors.yellow,
      "description": 'Personas con asma o plemas respiratorios',
      "level": 'Moderado',
      "range": '51 - 100',
    }
  ];

  Widget _buildProducts(context, int index) {
    return Scale(
      color: scalesList[index]['color'],
      range: scalesList[index]['range'],
      description: 'Cualquier actividad al aire libre',
      level: 'Bueno',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProducts,
      itemCount: scalesList.length,
    );
  }
}

class Scale extends StatelessWidget {
  String range = '';
  Color color = Colors.white;
  String level = '';
  String description = '';
  Scale({this.range, this.color, this.level, this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: color,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text("$range",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            )),
        SizedBox(width: 20),
        Container(
          child: Column(
            children: <Widget>[
              Text(
                level,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(description,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
