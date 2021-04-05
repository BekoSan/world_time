import 'package:world_time/services/world_time.dart';
import 'dart:convert';
import 'package:http/http.dart';

class Locations {
  static List<WorldTime> locations = [];

  static Future<void> loadLocations() async {
    try {
      var dataUrl = Uri.https('worldtimeapi.org', '/api/timezone');
      Response response = await get(dataUrl);
      List<dynamic> data = jsonDecode(response.body);

      data.forEach((element) {
        locations.add(WorldTime(
            location:
                element.substring(element.indexOf('/') + 1, element.length),
            url: element));
      });
    } catch (e) {
      print('Cant Fill the list: *** ($e) ***');
    }
  }
}
