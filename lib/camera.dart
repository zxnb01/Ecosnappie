import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:new_proj/addCaption.dart';
import 'package:new_proj/previewScreen.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  TextEditingController _captionController = TextEditingController();
  String _caption = "";

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _captionController.dispose();
    super.dispose();
  }

  // Future<void> _takePicture() async {
  //   try {
  //     await _initializeControllerFuture;
  //     final image = await _controller.takePicture();

  //     if (!mounted) return;

  //     // Get the application's document directory
  //     final Directory appDir = await getApplicationDocumentsDirectory();
  //     final String newPath =
  //         '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

  //     // Copy the image to a new path
  //     final File savedImage = await File(image.path).copy(newPath);

  //     // Navigate to preview screen with saved image path
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PreviewScreen(
  //           imagePath: savedImage.path, // Use the correct saved path
  //           caption: _caption,
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     print("Error taking picture: $e");
  //   }
  // }
  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture; // Ensure camera is initialized
      final XFile image = await _controller.takePicture(); // Capture the image

      if (!mounted) return;

      // Navigate to the CaptionScreen with the captured image path
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CaptionScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 150,
            left: 20,
            right: 20,
            child: TextField(
              controller: _captionController,
              onChanged: (text) {
                setState(() {
                  _caption = text;
                });
              },
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: "Type your caption...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              onPressed: _takePicture,
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}
