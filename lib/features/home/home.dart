import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/features/auth/login/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('No user is currently signed in.')),
      );
    }

    final userDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userDocument.snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasError) {
            return const Center(child: Text('Unable to load your profile.'));
          }
          if (!userSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = userSnapshot.data!.data();
          if (profile == null) {
            return const Center(child: Text('Your profile was not found.'));
          }

          final role = profile['role'] as String? ?? 'customer';
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Welcome, ${profile['fullName'] ?? 'User'}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              _InfoCard(
                title: 'Account information',
                children: [
                  _InfoRow(label: 'Email', value: currentUser.email ?? ''),
                  _InfoRow(label: 'Phone', value: profile['phone'] ?? ''),
                  _InfoRow(label: 'Role', value: role),
                ],
              ),
              if (role == 'seller') ...[
                const SizedBox(height: 16),
                _SellerShopCard(sellerId: currentUser.uid),
              ],
            ],
          );
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
