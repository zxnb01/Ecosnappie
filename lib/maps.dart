// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'challenge.dart';

// class MapsPage extends StatefulWidget {
//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   late final MapController _mapController;
//   LatLng? _userLocation;
//   double _currentZoom = 13.0;

//   final PopupController _popupController = PopupController();

//   final List<Marker> _volunteerMarkers = [
//     Marker(
//       point: LatLng(17.3850, 78.4867),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//     ),
//     Marker(
//       point: LatLng(17.3750, 78.4867),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//     ),
//     Marker(
//       point: LatLng(17.4150, 78.4702),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//     ),
//     Marker(
//       point: LatLng(17.4050, 78.4902),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//     ),
//   ];

//   final List<Marker> _businessMarkers = [
//     Marker(
//       point: LatLng(17.4050, 78.4967),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.blue, size: 40),
//     ),
//     Marker(
//       point: LatLng(17.3550, 78.5102),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.blue, size: 40),
//     ),
//     Marker(
//       point: LatLng(17.3544, 78.4702),
//       width: 40,
//       height: 40,
//       child: Icon(Icons.location_pin, color: Colors.blue, size: 40),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();
//     _getUserLocation();
//   }

//   Future<void> _getUserLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _userLocation = LatLng(position.latitude, position.longitude);
//       _mapController.move(_userLocation!, _currentZoom);
//     });
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom += 1.0;
//       _mapController.move(_mapController.camera.center, _currentZoom);
//     });
//   }

//   void _zoomOut() {
//     setState(() {
//       _currentZoom -= 1.0;
//       _mapController.move(_mapController.camera.center, _currentZoom);
//     });
//   }

//   void _openUrl(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open the URL')),
//       );
//     }
//   }

//   void _signUpForOpportunity() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Successfully signed up for volunteering!')),
//     );
//     _popupController.hideAllPopups();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//           AppBar(title: const Text("Eco Map"), backgroundColor: Colors.white),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               initialCenter: _userLocation ?? const LatLng(17.3850, 78.4867),
//               initialZoom: _currentZoom,
//               onTap: (_, __) => _popupController.hideAllPopups(),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate:
//                     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c'],
//               ),
//               MarkerLayer(markers: _volunteerMarkers + _businessMarkers),
//               if (_userLocation != null)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: _userLocation!,
//                       width: 50,
//                       height: 50,
//                       child: const Icon(Icons.location_pin,
//                           color: Colors.yellow, size: 50),
//                     ),
//                   ],
//                 ),
//               PopupMarkerLayer(
//                 options: PopupMarkerLayerOptions(
//                   popupController: _popupController,
//                   markers: _volunteerMarkers + _businessMarkers,
//                   popupDisplayOptions: PopupDisplayOptions(
//                     builder: (BuildContext context, Marker marker) {
//                       bool isBusiness = _businessMarkers.contains(marker);
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 isBusiness
//                                     ? "Sustainable Business"
//                                     : "Volunteering Opportunity",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 isBusiness
//                                     ? "Purchase clothing made from ethically sourced cotton and eco-friendly paractices."
//                                     : "Hussain Sagar Lake Cleanup!",
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () =>
//                                         _popupController.hideAllPopups(),
//                                     child: const Text("Close"),
//                                   ),
//                                   if (isBusiness)
//                                     TextButton(
//                                       onPressed: () => _openUrl(
//                                           "https://www.google.com/maps"),
//                                       child: const Text("Visit Now"),
//                                     ),
//                                   if (!isBusiness)
//                                     TextButton(
//                                       onPressed: _signUpForOpportunity,
//                                       child: const Text("Sign Up Now"),
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: _zoomIn,
//             backgroundColor: Colors.green[400],
//             child: const Icon(Icons.zoom_in),
//           ),
//           const SizedBox(height: 10),
//           FloatingActionButton(
//             onPressed: _zoomOut,
//             backgroundColor: Colors.green[400],
//             child: const Icon(Icons.zoom_out),
//           ),
//           const SizedBox(height: 10),
//           FloatingActionButton(
//             onPressed: _userLocation != null
//                 ? () => _mapController.move(_userLocation!, _currentZoom)
//                 : null,
//             backgroundColor: Colors.green[400],
//             child: const Icon(Icons.gps_fixed),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.emoji_events),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ChallengesPage()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.map),
//               onPressed: () {},
//             ),
//             const SizedBox(width: 48),
//             IconButton(
//               icon: const Icon(Icons.message),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(Icons.person),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// wprking ones

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import 'challenge.dart';
import 'msging.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  late final MapController _mapController;
  double _currentZoom = 13.0;
  final PopupController _popupController = PopupController();

  final LatLng _grietLocation = LatLng(17.5203, 78.3674);

  final List<Map<String, dynamic>> _locations = [
    {
      "point": LatLng(17.465063, 78.342562),
      "color": Colors.blue,
      "title": "Green Connexion",
      "rating": 3.0,
      "description":
          "Green Connexion is an Impact Finance Advisory firm supporting sustainable enterprises globally."
    },
    {
      "point": LatLng(17.433687, 78.417563),
      "color": Colors.blue,
      "title": "Beforest Lifestyle Solutions Pvt Ltd",
      "rating": 4.2,
      "description":
          "Beforest creates food and water secure landscapes using principles of permaculture and natural farming."
    },
    {
      "point": LatLng(17.529063, 78.357312),
      "color": Colors.blue,
      "title": "Biofactor - The Soil Company",
      "rating": 4.0,
      "description":
          "The go-to soil company for ethical and sustainable practices."
    },
    {
      "point": LatLng(17.456938, 78.373812),
      "color": Colors.blue,
      "title": "Universe of Good",
      "rating": 3.0,
      "description": "This NGO improves women's sanitation and hygiene."
    },
    {
      "point": LatLng(17.456938, 78.373812),
      "color": Colors.blue,
      "title": "CII-Sohrabji Godrej Green Business Centre",
      "rating": 2.0,
      "description":
          "A pioneering institute promoting green energy and sustainability."
    },
    {
      "point": LatLng(17.426563, 78.374062),
      "color": Colors.blue,
      "title": "Wudbox Enterprises LLP",
      "rating": 4.3,
      "description": "An eco-friendly gifting and lifestyle brand."
    },
    {
      "point": LatLng(17.526938, 78.371313),
      "color": Colors.red,
      "title": "Festivals for Joy",
      "rating": 4.6,
      "description":
          "Empowering marginalized communities through sustainable initiatives."
    },
    {
      "point": LatLng(17.507312, 78.340937),
      "color": Colors.red,
      "title": "The Chavadi Child Welfare Society",
      "rating": 4.1,
      "description":
          "Provides shelter and education to underprivileged children."
    },
    {
      "point": LatLng(17.513562, 78.392687),
      "color": Colors.red,
      "title": "LIFE Charitable Trust",
      "rating": 4.4,
      "description": "A non-profit providing medical aid, food, and shelter."
    },
    {
      "point": LatLng(17.5203, 78.3674),
      "color": Colors.yellow,
      "title": "Current Location",
      "rating": 4.9,
      "description":
          "The main campus of GRIET, known for engineering excellence."
    },
  ];

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  LatLng _currentCenter =
      LatLng(17.5203, 78.3674); // Initialize with your starting location

  void _zoomIn() {
    setState(() {
      _currentZoom++;
      _mapController.move(_currentCenter, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      if (_currentZoom > 1) {
        // Prevent zooming out too much
        _currentZoom--;
        _mapController.move(_currentCenter, _currentZoom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Eco Map"), backgroundColor: Colors.white),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _grietLocation,
          initialZoom: _currentZoom,
          onTap: (_, __) => _popupController.hideAllPopups(),
        ),
        children: [
          TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayer(
              markers: _locations
                  .map((loc) => Marker(
                      point: loc["point"],
                      width: 40,
                      height: 40,
                      child: Icon(Icons.location_pin,
                          color: loc["color"], size: 40)))
                  .toList()),
          PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
            popupController: _popupController,
            markers: _locations
                .map((loc) => Marker(
                    point: loc["point"],
                    width: 40,
                    height: 40,
                    child: Icon(Icons.location_pin,
                        color: loc["color"], size: 40)))
                .toList(),
            popupDisplayOptions:
                PopupDisplayOptions(builder: (context, marker) {
              final location =
                  _locations.firstWhere((loc) => loc["point"] == marker.point);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(location["title"],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      _buildRatingStars(location["rating"]),
                      Text(location["description"],
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            }),
          )),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _zoomIn,
            backgroundColor: Colors.green[400],
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _zoomOut,
            backgroundColor: Colors.green[400],
            child: const Icon(Icons.zoom_out),
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_events),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengesPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {},
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagingPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Handle camera action
      //   },
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.camera_alt),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
