import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_proj/snapsendingscreen.dart';

class PreviewScreen extends StatelessWidget {
  final String imagePath;
  final String caption;

  PreviewScreen({required this.imagePath, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview")),
      body: Stack(
        children: [
          Image.file(File(imagePath),
              width: double.infinity, fit: BoxFit.cover),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 4,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SendSnapScreen(imagePath: imagePath, caption: caption),
                  ),
                );
              },
              icon: Icon(Icons.send),
              label: Text("Send Snap"),
            ),
          ),
        ],
      ),
    );
  }
}
