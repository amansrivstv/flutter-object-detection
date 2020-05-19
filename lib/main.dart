import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'home.dart';
import 'pages/about_screen.dart';
import 'pages/database_screen.dart';
import 'pages/usage_screen.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crop Insect Detector",
      theme: new ThemeData(
        primaryColor: new Color(0xffff9800),
        accentColor: new Color(0xffffd180),
      ),
      home: new DetectorHome(),
    );
  }
}

class DetectorHome extends StatefulWidget {
  @override
  _DetectorHomeState createState() => _DetectorHomeState();
}

class _DetectorHomeState extends State<DetectorHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;


  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Insect Detector"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: "INSECT DATABASE"),
            Tab(
              text: "HOW TO USE",
            ),
            Tab(
              text: "ABOUT",
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Database(),
          Usage(),
          About(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.camera_enhance,
                color: Colors.white,
              ),
              onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(cameras)),
            );
          },
            ),
    );
  }
}