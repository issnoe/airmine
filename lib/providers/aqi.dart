import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

dynamic getNotifications() async {
  var jsonResponse;
  var provider;
  final url = "https://airmine-42cb4.firebaseio.com/notifications.json";
  //print(url);
  // Await the http get response, then decode the json-formatted responce.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);

    provider = jsonResponse;
  } else {
    print("Request failed $response.");
  }
  return provider;
}

dynamic aqiMapProvider(currentLocation) async {
  var jsonResponse;
  var provider;
  const apiToken = '15bae679176be73a9af8eabd9e9099d4b027828d';
  final latitud = currentLocation["latitude"].toString();
  final longitud = currentLocation["longitude"].toString();
  final url =
      'https://api.waqi.info/map/bounds/?token=$apiToken&latlng=19.3641383,-99.1329133,31.37357161574468,122.04025268554689';
  print(url);
  // Await the http get response, then decode the json-formatted responce.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);
    print('APIMAPARESPONSE' + jsonResponse.toString());
    provider = jsonResponse['data'];
  } else {
    print("Request failed $response.");
  }
  return provider;
}

dynamic aqiProvider(currentLocation) async {
  var jsonResponse;
  var provider;
  const apiToken = '15bae679176be73a9af8eabd9e9099d4b027828d';
  final latitud = currentLocation["latitude"].toString();
  final longitud = currentLocation["longitude"].toString();
  final geo = "geo:" + latitud + ";" + longitud;
  final url = "https://api.waqi.info/feed/" + geo + "/?token=$apiToken";
  print(url);
  // Await the http get response, then decode the json-formatted responce.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);

    provider = {
      "aqi": jsonResponse['data']['aqi'],
      'state': status(jsonResponse['data']['aqi']),
      "iaqi": jsonResponse['data']['iaqi']
    };
  } else {
    print("Request failed $response.");
  }
  return provider;
}

dynamic status(int aqi) {
  var status = '';
  var color = [
    Colors.yellow[400],
    Colors.green,
    Colors.green,
  ];
  var implicacion = "";
  var advertencias = "";

  if (aqi <= 50) {
    status = 'Bueno';
    color = [
      Colors.yellow[400],
      Colors.green,
      Colors.green,
    ];
    implicacion =
        "La calidad del aire se considera satisfactoria y la contaminación atmosférica plantea poco o ningún riesgo";
    advertencias = "Ninguna";
  }
  if (aqi > 50 && aqi <= 100) {
    status = 'Moderado';
    color = [
      Colors.green,
      Colors.yellow,
      Colors.yellow[400],
      Colors.yellow,
    ];
    implicacion =
        "La calidad del aire es aceptable; Sin embargo, hay algunos contaminantes que puede probocar un  problema moderado en la salud para un número muy pequeño de personas que son inusualmente sensibles a la contaminación del aire";
    advertencias =
        "Los niños y adultos activos, y las personas con enfermedades respiratorias, como el asma, deben limitar el esfuerzo al aire libre prolongado.";
  }
  if (aqi > 100 && aqi <= 150) {
    status = 'Insalubre';
    color = [
      Colors.yellow[400],
      Colors.orange,
      Colors.orange,
    ];
    implicacion =
        "Los miembros de grupos sensibles pueden experimentar efectos sobre la salud. No es probable que el público en general se vea afectado.";
    advertencias =
        "Los niños y adultos activos, y las personas con enfermedades respiratorias, como el asma, deben limitar el esfuerzo al aire libre prolongado.";
  }
  if (aqi > 150 && aqi <= 200) {
    status = 'Problematico';
    color = [
      Colors.orange[400],
      Colors.red,
      Colors.red,
    ];
    implicacion =
        "Todo el mundo puede comenzar a experimentar efectos sobre la salud; Los miembros de grupos sensibles pueden experimentar efectos más graves para la salud";
    advertencias =
        "Los niños y adultos activos y las personas con enfermedades respiratorias, como el asma, deben evitar el ejercicio prolongado al aire libre; Todos los demás, especialmente los niños, deben limitar el esfuerzo al aire libre prolongado";
  }

  if (aqi > 200 && aqi <= 300) {
    status = 'Grave';
    color = [
      Colors.red[300],
      Colors.red[400],
      Colors.brown,
    ];
    implicacion =
        "Advertencias sanitarias de condiciones de emergencia. Es más probable que toda la población se vea afectada.";
    advertencias =
        "Los niños y adultos activos, y las personas con enfermedades respiratorias, como el asma, deben evitar todo esfuerzo al aire libre; Todos los demás, especialmente los niños, deben limitar el esfuerzo al aire libre.";
  }
  if (aqi > 300) {
    status = 'Nocivo';
    color = [
      Colors.red[800],
      Colors.brown,
      Colors.brown,
    ];
    implicacion =
        "Alerta de salud: todos pueden experimentar efectos más graves para la salud";
    advertencias = "Todos deben evitar todo esfuerzo al aire libre";
  }
  var provider = {
    "status": status,
    "color": color,
    "implicacion": implicacion,
    "advertencias": advertencias,
  };
  return provider;
}

String getLabel(String label) {
  var names = {
    "pm25": "PM 2.5",
    "pm10": "PM 10",
    "o3": "Ozono",
    "no2": "Dioxido de Nitrogeno",
    "so2": "Dioxido Sulphur",
    "co": "Monoxido de Carbono",
    "t": "Temperatura",
    "w": "Viento",
    "r": "Precipitación",
    "h": "Humedad",
    "d": "Dew",
    "p": "Presión Atmostferica"
  };
  return names[label];
}

Color colorize(double aqi, String name) {
  if (name == 'p') {
    return Colors.white;
  }

  if (aqi < 50) {
    return Colors.green;
  }
  if (aqi > 51 && aqi < 100) {
    return Colors.yellow[400];
  }
  if (aqi > 100 && aqi < 150) {
    return Colors.orange;
  }

  return Colors.yellow[400];
}
