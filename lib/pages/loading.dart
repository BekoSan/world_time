import 'package:flutter/material.dart';
import 'package:world_time/locations.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

/*TODO: Use flags API
 Flags API : https://www.countryflags.io/:country_code/:style/:size.png*/

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    LocalTime instance = LocalTime();

    await instance.getTime();

    await Locations.loadLocations();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
