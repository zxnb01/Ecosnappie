// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class SendSnapScreen extends StatelessWidget {
//   final String imagePath;
//   final String caption;

//   SendSnapScreen({required this.imagePath, required this.caption});

//   final List<String> users = ["Alice", "Bob", "Charlie", "David", "Emily"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Send Snap To")),
//       body: Column(
//         children: [
//           Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Image.file(File(imagePath), height: 250, fit: BoxFit.cover),
//               if (caption.isNotEmpty)
//                 Container(
//                   color: Colors.black54,
//                   width: double.infinity,
//                   padding: EdgeInsets.all(10),
//                   child: Text(
//                     caption,
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(child: Text(users[index][0])),
//                   title: Text(users[index]),
//                   trailing: IconButton(
//                     icon: Icon(Icons.send, color: Colors.blue),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChatScreen(
//                             recipient: users[index],
//                             imagePath: imagePath,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   final String recipient;
//   final String imagePath;
//   ChatScreen({required this.recipient, required this.imagePath});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   String _category = "";
//   final TextEditingController _messageController = TextEditingController();
//   final String _apiKey = "AIzaSyAuQNEWjpgEU0gJPTmjAkb6vtiW1zJb-Kg";
//   List<Map<String, dynamic>> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _classifyImage(File(widget.imagePath));
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
//               {
//                 "inline_data": {"mime_type": "image/jpeg", "data": base64Image}
//               },
//               {
//                 "text":
//                     "I want you to understand the action going in the image and classify that image on the basis of eco-friendly actions: [Reuse, Reduce, No Plastic, Eco Friendly, None]. Respond only with the category letter."
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
//           "image": isImage ? File(widget.imagePath) : null,
//           "category": _category,
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
//         "sender": widget.recipient,
//         "text": "Got it! Thanks for the update.",
//         "image": null,
//         "category": null,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.recipient)),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 var message = messages[index];
//                 bool isUser = message["sender"] == "You";
//                 return Align(
//                   alignment:
//                       isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[200] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (message["text"] != null)
//                           Text(
//                             message["text"],
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         if (message["image"] != null) ...[
//                           SizedBox(height: 5),
//                           Image.file(message["image"], width: 150, height: 150),
//                           SizedBox(height: 5),
//                           Text("Category: ${message["category"]}"),
//                         ],
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _messageController,
//                   decoration: InputDecoration(hintText: "Type a message..."),
//                 ),
//               ),
//               IconButton(
//                   icon: Icon(Icons.send), onPressed: () => _sendMessage()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendSnapScreen extends StatelessWidget {
  final String imagePath;
  final String caption;

  SendSnapScreen({required this.imagePath, required this.caption});

  final List<String> users = ["Alice", "Bob", "Charlie", "David", "Emily"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Snap To")),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.file(File(imagePath), height: 250, fit: BoxFit.cover),
              if (caption.isNotEmpty)
                Container(
                  color: Colors.black54,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    caption,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text(users[index][0])),
                  title: Text(users[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            recipient: users[index],
                            imagePath: imagePath,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String recipient;
  final String imagePath;
  ChatScreen({required this.recipient, required this.imagePath});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _category = "";
  final TextEditingController _messageController = TextEditingController();
  final String _apiKey = "your_api_key";
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _classifyImage(File(widget.imagePath));
    _sendMessage(isImage: true);
  }

  Future<void> _classifyImage(File image) async {
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=$_apiKey");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "role": "user",
            "parts": [
              {
                "inline_data": {"mime_type": "image/jpeg", "data": base64Image}
              },
              {
                "text":
                    "I want you to understand the action going in the image and classify that image on the basis of eco-friendly actions: [Reuse, Reduce, No Plastic, Eco Friendly, None]. Respond only with the category letter."
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _category = data["candidates"]?[0]["content"]?["parts"]?[0]["text"] ??
            "Unknown";
      });
    } else {
      setState(() {
        _category = "Error";
      });
    }
  }

  void _sendMessage({bool isImage = false}) {
    String text = _messageController.text.trim();
    if (text.isNotEmpty || isImage) {
      setState(() {
        messages.add({
          "sender": "You",
          "text": isImage ? null : text,
          "image": isImage ? File(widget.imagePath) : null,
          "category": isImage ? _category : null,
        });
      });
      _messageController.clear();
      _simulateUser1Response();
    }
  }

  void _simulateUser1Response() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      messages.add({
        "sender": widget.recipient,
        "text": "Got it! Thanks for the update.",
        "image": null,
        "category": null,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipient)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                bool isUser = message["sender"] == "You";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message["text"] != null)
                          Text(
                            message["text"],
                            style: TextStyle(fontSize: 16),
                          ),
                        if (message["image"] != null) ...[
                          SizedBox(height: 5),
                          Image.file(message["image"], width: 150, height: 150),
                          SizedBox(height: 5),
                          Text("Category: ${message["category"]}"),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(hintText: "Type a message..."),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send), onPressed: () => _sendMessage()),
            ],
          ),
        ],
      ),
    );
  }
}
