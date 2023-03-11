import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_media/super_base.dart';

import 'homepage.dart';
import 'json/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
          cardTheme: const CardTheme(
              shadowColor: Colors.black26,
              elevation: 6.0
          ),
        appBarTheme: const AppBarTheme(
          elevation: 1.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black87
          ),
          titleTextStyle: TextStyle(
            color: Colors.black87
          )
        )
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends Superbase<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async  {
      var string = (await prefs).getString(userKey);
      if(string != null){
        if(mounted) {
          User.user = User.fromJson(jsonDecode(string));
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => const Homepage()));
        }
      }else if(mounted){
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const Homepage()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
