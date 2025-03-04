import 'package:flutter/material.dart';

import 'challenge.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/user.png'), // Replace with user image
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'UserDoodleDoo', // Replace with dynamic username
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Points: 1261', // Replace with actual user points
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Badges Section
              const Text(
                'Achievements & Badges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildBadge('assets/images/badge1.png', 'Save the Ocean'),
                  const SizedBox(width: 10),
                  _buildBadge('assets/images/badge2.png', 'Green Warrior'),
                  const SizedBox(width: 10),
                  _buildBadge(
                      'assets/images/badge3.png', 'Anti Plastic Action'),
                ],
              ),

              const SizedBox(height: 20), // Space between badges and rewards

              // Unlocked Rewards Section
              const Text(
                'Unlocked Rewards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Column(
                children: [
                  _buildRewardCard(
                      '₹100 Off Coupon', 'Valid on your next purchase'),
                  _buildRewardCard('Exclusive Badge', 'Unlocked: Elite Member'),
                  _buildRewardCard('Free Delivery', 'On orders above ₹500'),
                  _buildRewardCard(
                      'Double Points Day', 'Earn twice the points this week!'),
                ],
              ),
            ],
          ),
        ),
      ),

      // 🟢 Bottom Navigation Bar
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
                // Handle navigation to MapsPage
              },
            ),
            const SizedBox(width: 48), // Space for FAB
            IconButton(
              icon: const Icon(Icons.message), // Messages
              onPressed: () {
                // Handle navigation to MessagesPage
              },
            ),
            IconButton(
              icon: const Icon(Icons.person), // Profile
              onPressed: () {
                // Already on Profile Page, avoid unnecessary navigation
              },
            ),
          ],
        ),
      ),

      // 🟢 Floating Action Button (for Camera)
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

  // 🏅 Badge Widget
  Widget _buildBadge(String imagePath, String title) {
    return Column(
      children: [
        // Badge Image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8), // Space between image and caption
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // 🎁 Reward Card Widget
  Widget _buildRewardCard(String title, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.card_giftcard, color: Colors.green, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
