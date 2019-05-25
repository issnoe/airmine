import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

dynamic locationGeocode(currentLocation) async {
  String address = 'Unknow';
  const baseUrlGoogle = 'https://maps.google.com/maps/api/geocode/json';
  const googleMapsKey = 'AIzaSyAXlDTY4Se1XlhMS7p1mWuPwq56xtOw3f8';
  final latitud = currentLocation["latitude"].toString();
  final longitud = currentLocation["longitude"].toString();
  final lanLng = latitud + ',' + longitud;
  final urlGoogle = '$baseUrlGoogle?key=$googleMapsKey&latlng=$lanLng';
  var responseGoogle = await http.get(urlGoogle);
  if (responseGoogle.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(responseGoogle.body);
    var formattedAddress = jsonResponse['results'][0]['formatted_address'];
    var arrayAddress = formattedAddress.split(",");
    address = arrayAddress.skip(1).take(2).toList().join(',');
  } else {
    print("Request failed $responseGoogle.");
  }

  return address;
}
