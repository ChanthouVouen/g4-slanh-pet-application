import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final _settings = <_NotificationSetting>[
    _NotificationSetting(
      title: 'Order Updates',
      subtitle: 'Shipping, delivery, returns',
      enabled: true,
    ),
    _NotificationSetting(
      title: 'Promotions & Deals',
      subtitle: 'Flash sales, vouchers, coupons',
      enabled: true,
    ),
    _NotificationSetting(
      title: 'Service Reminders',
      subtitle: 'Upcoming appointments',
      enabled: true,
    ),
    _NotificationSetting(
      title: 'Pet Health Tips',
      subtitle: 'Weekly wellness reminders',
    ),
    _NotificationSetting(
      title: 'New Arrivals',
      subtitle: 'Products in your wishlist categories',
    ),
    _NotificationSetting(
      title: 'Community Updates',
      subtitle: 'Likes, comments, follows',
      enabled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF172033),
          tooltip: 'Back',
        ),
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE3E7EC)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _settings.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: Color(0xFFF0F1F3)),
              itemBuilder: (context, index) {
                final setting = _settings[index];
                return SizedBox(
                  height: 62,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 16, right: 8),
                    title: Text(
                      setting.title,
                      style: const TextStyle(
                        color: Color(0xFF101828),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      setting.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF8A94A6),
                        fontSize: 12,
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: setting.enabled,
                      onChanged: (value) {
                        setState(() => setting.enabled = value);
                      },
                      activeThumbColor: Colors.white,
                      activeTrackColor: const Color(0xFFFF6338),
                      inactiveTrackColor: const Color(0xFFF1EEEC),
                      inactiveThumbColor: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationSetting {
  _NotificationSetting({
    required this.title,
    required this.subtitle,
    this.enabled = false,
  });

  final String title;
  final String subtitle;
  bool enabled;
}
