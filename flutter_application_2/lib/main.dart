// ignore_for_file: prefer_const_constructors, unnecessary_new
// @dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/WeatherModels.dart';
import 'package:http/http.dart';
import 'WeatherModels.dart';
import 'Network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: controllerCity,

                  // ignore: deprecated_member_use
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide(),
                    ),
                    labelText: 'Entrez la ville',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.all(5.0),
                child: FloatingActionButton(
                  onPressed: () {
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Weather res = snapshot.data as Weather;
                          return Container(
                              margin: EdgeInsets.only(top: 30, bottom: 30),
                              width: 350,
                              height: 200,
                              alignment: Alignment.topCenter,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(30.0),
                                      topRight: const Radius.circular(30.0),
                                      bottomLeft: const Radius.circular(30.0),
                                      bottomRight:
                                          const Radius.circular(30.0))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      res
                                          .getFirstelement()
                                          .main
                                          .temp
                                          .toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 25),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      res.city.name,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                          fontSize: 15),
                                      textAlign: TextAlign.center,
                                    )
                                  ]));
                        } else {
                          return const Center(
                            child: Text('Une erreur est survenue !'),
                          );
                        }
                      },
                      future: getWeatherForecast(
                          cityName: controllerCity.text.toString().trim()),
                    );
                  },
                  tooltip: 'Rechercher',
                  child: const Icon(Icons.search),
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<Weather> getWeatherForecast({String cityName}) async {
  var finalUrl = "https://api.openweathermap.org/data/2.5/forecast?q=" +
      cityName +
      "&appid=413bbd0853ce7d7d122f0b12d44d652b";
  final response = await get(Uri.parse(finalUrl));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print("weather data : ${response.body}");
    return Weather.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error getting weather forecast");
  }
}
