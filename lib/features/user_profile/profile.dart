import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'package:slanh_pet_application/features/auth/login/login.dart';
import 'edit_profile.dart';
import 'addresses.dart';
import 'notification_settings.dart';
import 'settings.dart';
import 'wishlist.dart';
import 'package:slanh_pet_application/core/services/profile/profile_repository.dart';
import 'package:slanh_pet_application/core/models/profile/profile.dart';
import 'widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const int tabIndex = 4;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('No user is signed in.')));
    }

    return StreamBuilder<ProfileModel>(
      stream: ProfileRepository().watchProfile(user),
      builder: (context, snapshot) {
        final profile = snapshot.data;

        return Scaffold(
          backgroundColor: const Color(0xFFFFF8F4),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFF703C),
            foregroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'My Profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            actions: [
              if (profile != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => EditProfileScreen(
                          profile: profile,
                          onSave: (name, phone, dateOfBirth, bio, gender) =>
                              ProfileRepository().updateProfile(
                                userId: user.uid,
                                name: name,
                                phone: phone,
                                dateOfBirth: dateOfBirth,
                                bio: bio,
                                gender: gender,
                              ),
                          onPhotoSelected: (image) =>
                              ProfileRepository().updateProfilePhoto(
                                userId: user.uid,
                                image: image,
                              ),
                        ),
                      ),
                    ),
                    tooltip: 'Edit profile',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: .18),
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Unable to load your profile.'),
                );
              }
              if (profile == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: ProfileHero(profile: profile)),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 15),
                        AccountMenu(
                          onSignOut: () => _signOut(context),
                          onAddresses: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => AddressesScreen(
                                initialFullName: profile.name,
                              ),
                            ),
                          ),
                          onWishlist: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const WishlistScreen(),
                            ),
                          ),
                          onNotificationSettings: () =>
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      const NotificationSettingsScreen(),
                                ),
                              ),
                          onSettings: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const SettingsScreen(),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: tabIndex,
            onTap: (index) => switchBottomNavTab(
              context,
              currentIndex: tabIndex,
              index: index,
            ),
          ),
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }
}
