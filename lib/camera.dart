//importing packages
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

//setting up camera steam for detection
class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraState createState() => new _CameraState();
}
//initialize with isDetecting false
class _CameraState extends State<Camera> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
//check stream is null or not
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
//start detection
        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = new DateTime.now().millisecondsSinceEpoch;
            //passing byte steam to detector tflite
              Tflite.detectObjectOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                model: "YOLO",
                imageHeight: img.height,
                imageWidth: img.width,
                imageMean:0,
                imageStd: 255.0,
                //results per class allowed
                numResultsPerClass: 1,
                //detection threshold 
                threshold: 0.2,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");
// setting variables after detection for creating bounding box
                widget.setRecognitions(recognitions, img.height, img.width);
//set detector false
                isDetecting = false;
              });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
//checking if image bounding box is inside the screen, and if not, changing it to fit screen
    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
