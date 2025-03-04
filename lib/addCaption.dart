import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_proj/previewScreen.dart';
//import 'package:new_proj/snapsendingscreen.dart';

// class AddCaptionScreen extends StatefulWidget {
//   final String imagePath;

//   AddCaptionScreen({required this.imagePath});

//   @override
//   _AddCaptionScreenState createState() => _AddCaptionScreenState();
// }

// class _AddCaptionScreenState extends State<AddCaptionScreen> {
//   TextEditingController _captionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Add a Caption")),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 Image.file(File(widget.imagePath),
//                     width: double.infinity, fit: BoxFit.cover),
//                 Positioned(
//                   bottom: 20,
//                   left: 20,
//                   right: 20,
//                   child: TextField(
//                     controller: _captionController,
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                     decoration: InputDecoration(
//                       hintText: "Add a caption...",
//                       hintStyle: TextStyle(color: Colors.white70),
//                       filled: true,
//                       fillColor: Colors.black54,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SendSnapScreen(
//                       imagePath: widget.imagePath,
//                       caption: _captionController.text,
//                     ),
//                   ),
//                 );
//               },
//               child: Text("Next"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class CaptionScreen extends StatefulWidget {
  final String imagePath;

  CaptionScreen({required this.imagePath});

  @override
  _CaptionScreenState createState() => _CaptionScreenState();
}

class _CaptionScreenState extends State<CaptionScreen> {
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Caption")),
      body: Column(
        children: [
          Expanded(
              child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _captionController,
              decoration: InputDecoration(hintText: "Enter caption..."),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Move to the preview screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(
                    imagePath: widget.imagePath,
                    caption: _captionController.text,
                  ),
                ),
              );
            },
            child: Text("Next"),
          ),
        ],
      ),
    );
  }
}
