import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {

  String location; // Location to show the time
  String time; // Time to be displayed
  String flag; // url of the image 
  String url; // url of the location for api call
  bool isDaytime; // true or false value
  
  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {

      // HTTP request through api
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      // Converting string to DatTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(
        hours: int.parse(offset.substring(1, 3)), 
        minutes: int.parse(offset.substring(4, 6))
      ));

      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e) {
      print('Caught an error: $e');
      time = 'Could not find the Location: $location';
    }
  }
}