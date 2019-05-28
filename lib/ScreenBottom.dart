import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airmine/themes/colors.dart';
import 'package:airmine/widgets/scales.dart';
import 'package:airmine/providers/aqi.dart';

Widget getTextWidgets(var strings) {
  List<Widget> list = new List<Widget>();
  try {
    strings.forEach((name, v) {
      try {
        Color col = colorize(v['v'], name);
        list.add(Row(
          children: <Widget>[
            Scale(
              color: col,
              range: '${v['v']}',
              description: '',
              level: '${getLabel(name)}',
            ),
          ],
        ));
        list.add(SizedBox(height: 10));
      } catch (e) {
        print(e);
      }

      //list.add(new Text(''));
    });
    return new Column(children: list);
  } catch (e) {
    print(e);
  }

  return Container();
}

class ScreenBottom extends StatelessWidget {
  Map<String, dynamic> aqiData;
  ScreenBottom({this.aqiData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Estado",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${aqiData != null ? aqiData['state']['implicacion'] : '...'}",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Detalles",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child:
                      aqiData != null ? getTextWidgets(aqiData['iaqi']) : null,
                )
              ],
            ),
          ),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Advertencias",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${aqiData != null ? aqiData['state']['advertencias'] : '...'}",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: aqiData != null && aqiData['aqi'] > 200
                ? Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Recomendaciones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        children: <Widget>[
                          FlightDetailChip(
                            Icons.directions_run,
                            'No correr',
                          ),
                          FlightDetailChip(
                            Icons.exit_to_app,
                            'Salir de casa',
                          ),
                          FlightDetailChip(
                            Icons.child_friendly,
                            'Niños',
                          ),
                          FlightDetailChip(
                            Icons.face,
                            'Personas 3ra/edad',
                          ),
                        ],
                      )
                    ],
                  )
                : null,
          ),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Escalas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Para reportar la calidad del aire, el índice emplea seis categorías, los cuales se han ido reduciendo conforme se ha mejorado la calidad del aire en los últimos 20 años:",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 15),
                Scale(
                  color: Colors.green,
                  range: '      0 - 50',
                  description: 'Cualquier actividad al aire libre',
                  level: 'Bueno',
                ),
                SizedBox(height: 18),
                Scale(
                  color: Colors.yellow[600],
                  range: '  51 - 100',
                  description: 'Cualquier actividad al aire libre',
                  level: 'Moderado',
                ),
                SizedBox(height: 18),
                Scale(
                  color: Colors.orange[600],
                  range: '101 - 150',
                  description: 'Evitar tiempos prolongados',
                  level: 'Insalubre',
                ),
                SizedBox(height: 18),
                Scale(
                  color: Colors.red[600],
                  range: '151 - 200',
                  description: 'Evitar tiempos prolongados',
                  level: 'Problematico',
                ),
                SizedBox(height: 18),
                Scale(
                  color: Colors.red[900],
                  range: '200 - 300',
                  description: 'Evitar tiempos prolongados',
                  level: 'Grave',
                ),
                SizedBox(height: 18),
                Scale(
                  color: Colors.brown,
                  range: '301 - 500',
                  description: 'Ninguna actividad al aire libre',
                  level: 'Nocivo',
                ),
              ],
            ),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}

class FlightDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;

  FlightDetailChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(
          color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w300),
      backgroundColor: Colors.white10,
      avatar: Icon(
        iconData,
        size: 30.0,
        color: Colors.red[600],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
