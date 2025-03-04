// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   File? _image;
//   String _category = "";
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController _messageController = TextEditingController();
//   final String _apiKey = "AIzaSyAuQNEWjpgEU0gJPTmjAkb6vtiW1zJb-Kg";
//   List<Map<String, dynamic>> messages = [];

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       await _classifyImage(_image!);
//       _sendMessage(isImage: true);
//     }
//   }

//   Future<void> _classifyImage(File image) async {
//     final bytes = await image.readAsBytes();
//     final base64Image = base64Encode(bytes);

//     final url = Uri.parse(
//         "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=$_apiKey");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "contents": [
//           {
//             "role": "user",
//             "parts": [
//               {"inline_data": {"mime_type": "image/jpeg", "data": base64Image}},
//               {
//                 "text":
//                     "I want you to understand the action going in the image and classify that image on the basis of eco friendly actions: [Reuse, Reduce, No Plastic, Eco Friendly, None]. Respond only with the category letter."
//               }
//             ]
//           }
//         ]
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         _category = data["candidates"]?[0]["content"]?["parts"]?[0]["text"] ??
//             "Unknown";
//       });
//     } else {
//       setState(() {
//         _category = "Error";
//       });
//     }
//   }

//   void _sendMessage({bool isImage = false}) {
//     String text = _messageController.text.trim();
//     if (text.isNotEmpty || isImage) {
//       setState(() {
//         messages.add({
//           "sender": "You",
//           "text": isImage ? null : text,
//           "image": isImage ? _image : null,
//           "category": isImage ? _category : null,
//         });
//       });
//       _messageController.clear();
//       _simulateUser1Response();
//     }
//   }

//   void _simulateUser1Response() async {
//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       messages.add({
//         "sender": "user1",
//         "text": "Got it! Thanks for the update.",
//         "image": null,
//         "category": null,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("User1")),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   var message = messages[index];
//                   bool isUser = message["sender"] == "You";
//                   return Align(
//                     alignment:
//                         isUser ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: isUser ? Colors.blue[200] : Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (message["text"] != null)
//                             Text(
//                               message["text"],
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           if (message["image"] != null) ...[
//                             SizedBox(height: 5),
//                             Image.file(message["image"],
//                                 width: 150, height: 150),
//                             SizedBox(height: 5),
//                             Text("Category: ${message["category"]}"),
//                           ],
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type a message...",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () => _sendMessage(),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.camera_alt),
//                   onPressed: _pickImage,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'challenge.dart';
import 'maps.dart';
import 'profile.dart';

class MessagingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/msg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_events), // Challenges
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.map), // Maps
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapsPage()),
                );
              },
            ),
            const SizedBox(width: 48), // Space for FAB
            IconButton(
              icon: const Icon(Icons.message), // Messages (Current Page)
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person), // Profile
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle camera action
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
