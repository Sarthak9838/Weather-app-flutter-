import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const api='8fc6d74e61f76d74a72f8a3cbd8627af';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getlocationdata();
  }
  void getlocationdata() async{
    Location location = Location();
    await location.getLocation();
    latitude= location.latitude;
    longitude=location.longitude;
    Networkhelper networkdata= Networkhelper(url:'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$api&units=metric');
  var weatherData=await networkdata.getdata();
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return LocationScreen(locationdata: weatherData);
  }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }
}

