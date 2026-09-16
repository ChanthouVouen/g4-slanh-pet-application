import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/constants/app_colors.dart';
import 'package:slanh_pet_application/core/services/shop/shop_service.dart';
import 'package:slanh_pet_application/core/widgets/auth_submit_button.dart';
import 'package:slanh_pet_application/features/auth/login/login.dart';
import 'package:slanh_pet_application/core/models/commerce/shop.dart';
import 'package:slanh_pet_application/features/user_profile/widgets/edit_profile_widgets.dart';

import '../widgets/shop_owner_scaffold.dart';
import '../widgets/shop_profile_header.dart';

class ShopSettingsScreen extends StatefulWidget {
  const ShopSettingsScreen({super.key});

  @override
  State<ShopSettingsScreen> createState() => _ShopSettingsScreenState();
}

class _ShopSettingsScreenState extends State<ShopSettingsScreen> {
  static const int _tabIndex = 3;

  final _shopService = ShopService();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isOpen = true;
  bool _loaded = false;
  bool _saving = false;

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _taglineController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _applyShop(Shop shop) {
    _nameController.text = shop.name;
    _taglineController.text = shop.tagline;
    _phoneController.text = shop.phone;
    _emailController.text = shop.email;
    _addressController.text = shop.address;
    _isOpen = shop.isOpen;
  }

  Future<void> _save(Shop current) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final updated = Shop(
      id: current.id,
      image: current.image,
      name: _nameController.text.trim(),
      rating: current.rating,
      followers: current.followers,
      tagline: _taglineController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      isOpen: _isOpen,
    );

    try {
      await _shopService.updateShop(updated);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Shop profile updated.')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save shop profile: $error')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return ShopOwnerScaffold(
      title: 'Shop Profile',
      currentIndex: _tabIndex,
      body: uid == null
          ? const Center(child: Text('No user is signed in.'))
          : StreamBuilder<Shop?>(
              stream: _shopService.watchShop(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final shop =
                    snapshot.data ??
                    Shop(
                      id: uid,
                      image: '',
                      name: '',
                      rating: 0,
                      followers: '0',
                    );

                if (!_loaded) {
                  _applyShop(shop);
                  _loaded = true;
                }

                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                    children: [
                      ShopProfileHeader(
                        shop: shop,
                        isOpen: _isOpen,
                        onOpenChanged: (value) =>
                            setState(() => _isOpen = value),
                      ),
                      const Text(
                        'SHOP INFORMATION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.labelGray,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ProfileField(
                        label: 'Shop name',
                        controller: _nameController,
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Enter your shop name'
                            : null,
                      ),
                      ProfileField(
                        label: 'Tagline',
                        controller: _taglineController,
                      ),
                      ProfileField(
                        label: 'Phone',
                        controller: _phoneController,
                      ),
                      ProfileField(
                        label: 'Email',
                        controller: _emailController,
                      ),
                      ProfileField(
                        label: 'Address',
                        controller: _addressController,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      AuthSubmitButton(
                        label: 'Save Changes',
                        isSubmitting: _saving,
                        onPressed: () => _save(shop),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () => _signOut(context),
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text(
                            'Sign out',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
