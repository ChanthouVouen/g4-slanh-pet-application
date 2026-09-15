import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import 'profile_image.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({super.key, required this.profile, required this.onEdit});

  final ProfileModel profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 282,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 260,
            width: double.infinity,
            child: ProfileHeader(profile: profile, onEdit: onEdit),
          ),
          const Positioned(
            top: 210,
            left: 16,
            right: 16,
            child: ProfileStats(),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile, required this.onEdit});

  final ProfileModel profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 42),
      decoration: const BoxDecoration(
        color: Color(0xFFFF703C),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              IconButton(
                onPressed: onEdit,
                tooltip: 'Edit profile',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: .18),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                backgroundImage: profileImageProvider(profile.photoUrl),
                child: profile.photoUrl?.isNotEmpty == true
                    ? null
                    : Text(
                        profile.name[0].toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFFF703C),
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 9),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        child: Text(
                          profile.role == 'seller'
                              ? 'Seller account'
                              : 'Pet parent',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('Orders', '0'),
      ('Pets', '0'),
      ('Reviews', '0'),
      ('Saved', 'RM 0'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final stat in stats)
            Column(
              children: [
                Text(
                  stat.$2,
                  style: const TextStyle(
                    color: Color(0xFFFF5F35),
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat.$1,
                  style: const TextStyle(
                    color: Color(0xFF7C8495),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    super.key,
    required this.onSignOut,
    required this.onAddresses,
    required this.onWishlist,
    required this.onNotificationSettings,
    required this.onSettings,
  });

  final VoidCallback onSignOut;
  final VoidCallback onAddresses;
  final VoidCallback onWishlist;
  final VoidCallback onNotificationSettings;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.favorite_border, 'Wishlist', '4'),
      (Icons.location_on_outlined, 'Addresses', null),
      (Icons.notifications_none, 'Notification Settings', null),
      (Icons.settings, 'Settings', null),
    ];
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFECE8E5)),
      ),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                minTileHeight: 72,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFFFF0E9),
                  foregroundColor: const Color(0xFFFF6338),
                  child: Icon(items[index].$1, size: 20),
                ),
                title: Text(
                  items[index].$2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (items[index].$3 != null)
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: const Color(0xFFFF6A3D),
                        foregroundColor: Colors.white,
                        child: Text(
                          items[index].$3!,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                    const Icon(Icons.chevron_right, color: Color(0xFF9297A4)),
                  ],
                ),
                onTap: switch (items[index].$2) {
                  'Wishlist' => onWishlist,
                  'Addresses' => onAddresses,
                  'Notification Settings' => onNotificationSettings,
                  'Settings' => onSettings,
                  _ => () {},
                },
              ),
            ),
            if (index < items.length - 1) const Divider(height: 1, indent: 0),
          ],
          const Divider(height: 1, indent: 0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              minTileHeight: 72,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFFFF0E9),
                foregroundColor: Color(0xFFFF6338),
                child: Icon(Icons.logout, size: 20),
              ),
              title: const Text(
                'Sign out',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showEditProfileSheet(
  BuildContext context, {
  required String name,
  required String phone,
  required Future<void> Function(String name, String phone) onSave,
}) async {
  final nameController = TextEditingController(text: name);
  final phoneController = TextEditingController(
    text: phone == 'Add your phone number' ? '' : phone,
  );
  final formKey = GlobalKey<FormState>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        4,
        20,
        MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Edit profile', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your name'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                await onSave(nameController.text, phoneController.text);
                if (sheetContext.mounted) Navigator.pop(sheetContext);
              },
              child: const Text('Save changes'),
            ),
          ],
        ),
      ),
    ),
  );
  nameController.dispose();
  phoneController.dispose();
}
