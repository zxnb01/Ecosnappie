import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new_proj/profile.dart';

import '../challenge.dart';
import '../maps.dart';
import 'cart.dart';
// import 'cart_provider.dart';

void main() {
  runApp(MaterialApp(
    home: MarketplacePage(),
  ));
}

class MarketplacePage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Smart Composter',
      'price': 12000,
      'condition': 'Used',
      'images': [
        'assets/marketplace/lomi/lomi_m.png',
        'assets/marketplace/lomi/lomi_f.png',
        'assets/marketplace/lomi/lomi_d.png',
        'assets/marketplace/lomi/lomi_m.png',
        'assets/marketplace/lomi/lomi_s.png'
      ],
      'description':
          'Condition: Lightly Used\nTransform your kitchen waste into nutrient-rich compost effortlessly with this Smart Composter. Designed for efficiency, it accelerates the composting process using advanced technology, reducing waste and promoting sustainable living. Perfect for homes and small gardens, this composter is easy to use and helps you contribute to an eco-friendly lifestyle.'
    },
    {
      'name': 'Bamboo T-Brush',
      'price': 120,
      'condition': 'New',
      'images': [
        'assets/marketplace/brush/brush_m.png',
        'assets/marketplace/brush/brush_g.png',
        'assets/marketplace/brush/brush_i.png'
      ],
      'description':
          'Switch to a natural and chemical-free oral care solution with the Bamboo Datoon. Traditionally used in Ayurveda, this eco-friendly toothbrush alternative not only keeps your teeth clean but also supports sustainable living. Made from organically sourced bamboo twigs, it is biodegradable and completely plastic-free.'
    },
    {
      'name': 'Chew Toy',
      'price': 600,
      'condition': 'New',
      'images': [
        'assets/marketplace/chewtoy/chew_m.png',
        'assets/marketplace/chewtoy/chew_2.png'
      ],
      'description':
          'Keep your pets entertained and engaged with this Chew Toy, designed for durability and long-lasting fun. Made from non-toxic, pet-safe materials, this toy is perfect for teething puppies and active dogs, helping to clean their teeth while satisfying their natural chewing instincts.'
    },
    {
      'name': 'Throw',
      'price': 350,
      'condition': 'Used',
      'images': [
        'assets/marketplace/throw/throw_m.png',
        'assets/marketplace/throw/throw_c.png',
        'assets/marketplace/throw/throw_n.png'
      ],
      'description':
          'Condition: Lightly Used\nAdd a touch of warmth and comfort to your home with this cozy Throw blanket. Made from soft and breathable fabric, perfect for snuggling on chilly evenings or as a stylish accent for your living space. Whether youre lounging on the couch or adding a decorative touch to your bed, this throw offers both functionality and style.'
    },
    {
      'name': 'Solar Charger',
      'price': 3000,
      'condition': 'Used',
      'images': ['assets/marketplace/solarcharger/solar_m.png'],
      'description':
          'Condition: Lightly Used\nStay powered up wherever you go with this Solar Charger, an eco-friendly and portable solution for charging your devices. Whether youre hiking, camping, or simply reducing your carbon footprint, this charger efficiently converts sunlight into energy, ensuring you stay connected even in remote locations.'
    },
    {
      'name': 'Poop Bag',
      'price': 60,
      'condition': 'New',
      'images': [
        'assets/marketplace/poopbag/poop_main.png',
        'assets/marketplace/poopbag/poop_2.png'
      ],
      'description':
          'Make pet waste disposal hassle-free with these biodegradable Poop Bags. Designed for durability and leak-proof performance, these bags are eco-friendly and easy to carry, ensuring a clean and responsible way to handle your pet’s waste while on walks or in the park.'
    },
  ];

  Color getConditionColor(String? condition) {
    if (condition == 'New') return Colors.green;
    if (condition == 'Used') return Colors.orange;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StaticCartPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      color: getConditionColor(product['condition']),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 157,
                            child: Image.asset(
                              product['images'][0] ?? 'assets/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product['name'] ?? 'Unknown',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '₹${product['price'] ?? 0}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.emoji_events),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengesPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapsPage()),
                );
              },
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
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
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ShoppingCartPage()),
              // );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 250.0, enableInfiniteScroll: true, autoPlay: true),
              items: (product['images'] as List<String>).map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(image,
                        fit: BoxFit.cover, width: double.infinity);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['name'] ?? 'Unknown',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${product['price'] ?? 0}',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add to Cart'),
            ),
            SizedBox(height: 20),
            Text(
              'Product Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              product['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
