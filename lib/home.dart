//imports
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'camera.dart';
import 'bndbox.dart';


//defining the model as a constant for easier understanding
const String yolo = "Tiny YOLOv2";

// getting camera steram
class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  //defining variables for onject width and height
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "yolo";

  //initializing model
  @override
  void initState() {
    super.initState();
    onSelect(yolo);
  }
//loading assets: model and lables
  loadModel() async {
    String res;
    res = await Tflite.loadModel(
    model: "assets/yolov2_tiny.tflite",
    labels: "assets/yolov2_tiny.txt",);
    print(res);
  }
  
  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }
//fuction for setting variables after detection
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                //creating bounding box around detected image
                BndBox(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
              ],
            ),
    );
  }
}
