import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile.dart';

class ChallengesPage extends StatelessWidget {
  final List<Map<String, dynamic>> challenges = [
    {
      "name": "Plastic-Free Week 🥽",
      "image": "assets/images/challenge1.png",
      "description":
          "🌍♻️ Challenge yourself to go an entire week without using single-use plastic products! Swap out plastic bags for reusable totes, use metal or bamboo straws, bring your own water bottle, and opt for sustainable packaging. This small change can significantly reduce plastic waste and help protect marine life and the environment. Can you make it through the week without plastic?\n",
      "participants": 1200
    },
    {
      "name": "Bike to Work 🚴",
      "image": "assets/images/challenge2.png",
      "description":
          "🚴‍♂️🌱 Reduce your carbon footprint and stay active by biking to work instead of driving! Cycling not only helps decrease air pollution but also improves your health and fitness. Whether it’s a short commute or a longer ride, this challenge encourages you to embrace eco-friendly transport and make your daily journey more sustainable. Ready to pedal your way to a greener future?\n",
      "participants": 850
    },
    {
      "name": "Meat-Free Monday 🍄",
      "image": "assets/images/challenge3.png",
      "description":
          "🥦🌎 Join the global movement to reduce meat consumption and lower greenhouse gas emissions! For one day each week, switch to plant-based meals and explore delicious vegetarian and vegan options. By participating, you’re contributing to a more sustainable food system while discovering new flavors and healthier eating habits. Let\’s make a difference—one meal at a time!\n",
      "participants": 1900
    },
    {
      "name": "Tree Planting Drive 🎄",
      "image": "assets/images/challenge4.png",
      "description":
          "🌳💚 Take part in a greener tomorrow by planting at least one tree this weekend! Trees help combat climate change, improve air quality, and provide habitats for wildlife. Whether you plant a tree in your backyard, at a community park, or with an organization, your small action will have a lasting impact. Let’s grow a better future together!\n",
      "participants": 2300
    }
  ];

  final List<Map<String, dynamic>> leaderboard = [
    {"name": "🥇 Alice", "points": 1500},
    {"name": "🥈 Bob", "points": 1350},
    {"name": "🥉 Charlie", "points": 1200},
    {"name": "Ruhi", "points": 1050},
    {"name": "You", "points": 980},
    {"name": "David", "points": 820},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Challenges 🏆",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Carousel Slider (25% of screen height)
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: challenges.map((challenge) {
              return GestureDetector(
                onTap: () {
                  _showChallengePopup(context, challenge);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(challenge["image"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        challenge["name"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20),

          // Leaderboard Section (40% of screen height)
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Leaderboard 👑",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: leaderboard.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey[300]),
                    itemBuilder: (context, index) {
                      Color? bgColor;
                      if (index == 0)
                        bgColor = Colors.amber[100]; // Gold
                      else if (index == 1)
                        bgColor =
                            const Color.fromARGB(255, 206, 204, 204); // Silver
                      else if (index == 2)
                        bgColor = Colors.brown[300]; // Bronze
                      else if (leaderboard[index]["name"] == "You")
                        bgColor = Colors.green[100]; // Highlight "You"

                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 14, // Smaller avatar
                                  child: Text("${index + 1}"),
                                  backgroundColor: Colors.grey[700],
                                  foregroundColor: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  leaderboard[index]["name"],
                                  style: TextStyle(
                                    fontWeight:
                                        leaderboard[index]["name"] == "You"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${leaderboard[index]["points"]} pts",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Challenges Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Challenges 🏋️",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: challenges.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _showChallengePopup(context, challenges[index]);
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Image.asset(challenges[index]["image"],
                                  width: 50, height: 50, fit: BoxFit.cover),
                              title: Text(challenges[index]["name"]),
                              subtitle: Text(
                                  "${challenges[index]["participants"]} participants"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.emoji_events), // Challenges
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ChallengesPage()),
                // );
              },
            ),
            IconButton(
              icon: Icon(Icons.map), // Maps
              onPressed: () {},
            ),
            SizedBox(width: 48), // Space for FAB
            IconButton(
              icon: Icon(Icons.message), // Messages
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person), // Profile
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
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Function to Show Challenge Popup
  void _showChallengePopup(
      BuildContext context, Map<String, dynamic> challenge) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(challenge["name"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(challenge["image"], fit: BoxFit.cover),
              SizedBox(height: 10),
              Text(challenge["description"]),
              SizedBox(height: 10),
              Text("Participants: ${challenge["participants"]}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
              },
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("You have joined this challenge 🚀"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text("Quick Join"),
            ),
          ],
        );
      },
    );
  }
}
