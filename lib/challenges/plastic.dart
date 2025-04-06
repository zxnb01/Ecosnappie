import 'package:flutter/material.dart';

import '../challenge.dart';
import '../maps.dart';
import '../profile.dart';

class PlasticFreeChallengePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plastic-Free Week Challenge")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with title overlay
              Stack(
                children: [
                  Opacity(
                    opacity: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/challenge1.png',
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Plastic-Free Week",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Challenge Duration
              Text(
                "Challenge Duration: 7 Days",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),

              SizedBox(height: 10),

              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: 0.8, // 80% completion
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                    minHeight: 10,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "80% of the goal for this challenge has been met",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Challenge Description
              Text(
                "Join the Plastic-Free Week challenge and reduce single-use plastics! "
                "Take simple steps like using reusable bags, bottles, and avoiding plastic packaging.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              // Join Now Button aligned to the right
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement join challenge functionality
                  },
                  child: Text("Join Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Leaderboard
              Text(
                "Leaderboard",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text("1"),
                      ),
                      title: Text("Alex Johnson"),
                      trailing: Text("1200 pts",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text("2"),
                      ),
                      title: Text("Emma Williams"),
                      trailing: Text("1100 pts",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: Text("3"),
                      ),
                      title: Text("Liam Brown"),
                      trailing: Text("1050 pts",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
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

      // Floating Action Button (FAB) in the Center
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
