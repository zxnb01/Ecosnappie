import 'package:flutter/material.dart';

class StaticCartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Chew Toy',
      'price': 600,
      'condition': 'New',
      'image': 'assets/marketplace/chewtoy/chew_m.png',
    },
    {
      'name': 'Throw',
      'price': 350,
      'condition': 'Used',
      'image': 'assets/marketplace/throw/throw_m.png',
    },
    {
      'name': 'Solar Charger',
      'price': 3000,
      'condition': 'Used',
      'image': 'assets/marketplace/solarcharger/solar_m.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    int totalPrice =
        cartItems.fold(0, (sum, item) => sum + (item['price'] as int));

    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.asset(
                        cartItems[index]['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(cartItems[index]['name']),
                      subtitle:
                          Text('Condition: ${cartItems[index]['condition']}'),
                      trailing: Text('₹${cartItems[index]['price']}'),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Total: ₹$totalPrice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
