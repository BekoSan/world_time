import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      var dataUrl = Uri.https('worldtimeapi.org', '/api/timezone/$url');
      Response response = await get(dataUrl);
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error on : $e');
      time = 'Could not get time';
    }
  }
}

class LocalTime extends WorldTime {
  LocalTime();

  @override
  Future<void> getTime() async {
    try {
      var dataUrl = Uri.https('worldtimeapi.org', '/api/ip');
      Response response = await get(dataUrl);
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
      String timeZone = data['timezone'].toString();
      location = timeZone.substring(timeZone.indexOf('/') + 1, timeZone.length);
      url = data['timezone'];
    } catch (e) {
      print('Error on : $e');
      time = 'Could not get time';
    }
  }
}
