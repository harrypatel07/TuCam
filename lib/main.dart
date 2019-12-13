import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class CameraApp extends StatelessWidget {
  final millennialPink = Colors.pink[100];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: millennialPink,
        buttonTheme: ButtonThemeData(
          buttonColor: millennialPink,
        ),
        iconTheme: IconThemeData(
          color: millennialPink,
        )
      ),
      home: CameraHome(defaultCamera),
    );
  }
}

List<CameraDescription> cameras = [];
CameraDescription defaultCamera;

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (o) => o.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first
    );
    defaultCamera = frontCamera;
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(CameraApp());
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');
