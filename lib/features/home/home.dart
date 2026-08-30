import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/auth/login/login.dart';
import 'package:slanh_pet_application/features/home/home_page.dart';
import './widget_home/Popular_product_part/data/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Users'),
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text("Home Page"),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // 1. Define the stream from Firestore
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          // 2. Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // 3. Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 4. Check if data is empty
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          // 5. Build list with data
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  // ប្រសិនបើមាន URL ឱ្យបង្ហាញរូបភាព បើគ្មានទេឱ្យបង្ហាញ Icon ជំនួស
                  backgroundImage: user['image'] != null
                      ? NetworkImage(user['image'])
                      : null,
                  child: user['image'] == null
                      ? const Icon(Icons.person)
                      : null,
                ),

                title: Text(user['name'] ?? 'No Name'),
                // subtitle: Text(user['email'] ?? 'No Email'),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _tabIndex,
        onTap: (index) {
          switchBottomNavTab(context, currentIndex: _tabIndex, index: index);
        },
      ),
    );
  }
}

class _SellerShopCard extends StatelessWidget {
  const _SellerShopCard({required this.sellerId});

  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('shops')
          .doc(sellerId)
          .snapshots(),
      builder: (context, shopSnapshot) {
        if (shopSnapshot.hasError) {
          return const _InfoCard(
            title: 'Shop information',
            children: [Text('Unable to load your shop information.')],
          );
        }
        if (!shopSnapshot.hasData) {
          return const _InfoCard(
            title: 'Shop information',
            children: [Center(child: CircularProgressIndicator())],
          );
        }

        final shop = shopSnapshot.data!.data();
        if (shop == null) {
          return const _InfoCard(
            title: 'Shop information',
            children: [Text('No shop information has been added yet.')],
          );
        }

        return _InfoCard(
          title: 'Shop information',
          children: [
            _InfoRow(label: 'Shop name', value: shop['shopName'] ?? ''),
            _InfoRow(label: 'Address', value: shop['shopAddress'] ?? ''),
          ],
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final Object value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 92, child: Text(label)),
          Expanded(child: Text(value.toString())),
        ],
      ),
    );
  }
}
