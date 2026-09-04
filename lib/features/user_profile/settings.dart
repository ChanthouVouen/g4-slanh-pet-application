import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slanh_pet_application/core/navigation/bottom_nav_routes.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settings = <_SettingSection>[
    _SettingSection(
      title: 'NOTIFICATIONS',
      rows: [
        _SettingRow('Push Notifications', enabled: true),
        _SettingRow('Email Notifications', enabled: true),
        _SettingRow('SMS Alerts'),
      ],
    ),
    _SettingSection(
      title: 'PRIVACY',
      rows: [
        _SettingRow('Location Services', enabled: true),
        _SettingRow('Share Activity'),
      ],
    ),
    _SettingSection(
      title: 'APP',
      rows: [
        _SettingRow('Dark Mode'),
        _SettingRow('Language', value: 'English'),
        _SettingRow('Currency', value: 'MYR (RM)'),
      ],
    ),
    _SettingSection(
      title: 'ACCOUNT',
      rows: [
        _SettingRow('Change Password', showsChevron: true),
        _SettingRow('Two-Factor Auth', value: 'Off'),
      ],
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
          'Settings',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        titleSpacing: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: _settings.length,
        itemBuilder: (context, sectionIndex) {
          final section = _settings[sectionIndex];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    section.title,
                    style: const TextStyle(
                      color: Color(0xFF8790A3),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _SettingsCard(
                  rows: section.rows,
                  onToggle: (row, value) {
                    setState(() => row.enabled = value);
                  },
                  onTap: (row) {
                    if (row.title == 'Change Password') {
                      _changePassword();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: (index) =>
            switchBottomNavTab(context, currentIndex: 4, index: index),
      ),
    );
  }

  Future<void> _changePassword() async {
    final values = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: const Color(0xFFFFFCFA),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: const _ChangePasswordDialog(),
      ),
    );
    if (values == null) return;

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      _showMessage('No email/password account is signed in.');
      return;
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: values['currentPassword']!,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(values['newPassword']!);
      if (mounted) _showMessage('Password changed successfully.');
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      final message =
          error.code == 'wrong-password' || error.code == 'invalid-credential'
          ? 'Current password is incorrect.'
          : error.code == 'weak-password'
          ? 'New password is too weak.'
          : error.message ?? 'Unable to change password.';
      _showMessage(message);
    } catch (error) {
      if (mounted) _showMessage('Unable to change password: $error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.rows,
    required this.onToggle,
    required this.onTap,
  });

  final List<_SettingRow> rows;
  final void Function(_SettingRow row, bool value) onToggle;
  final void Function(_SettingRow row) onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE3E7EC)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            for (var index = 0; index < rows.length; index++) ...[
              SizedBox(
                height: 51,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 14),
                  onTap: rows[index].showsChevron
                      ? () => onTap(rows[index])
                      : null,
                  title: Text(
                    rows[index].title,
                    style: const TextStyle(
                      color: Color(0xFF101828),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: rows[index].value != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              rows[index].value!,
                              style: const TextStyle(
                                color: Color(0xFF8790A3),
                                fontSize: 14,
                              ),
                            ),
                            if (rows[index].showsChevron)
                              const Icon(Icons.chevron_right, size: 18),
                          ],
                        )
                      : rows[index].showsChevron
                      ? const Icon(Icons.chevron_right, size: 18)
                      : Switch.adaptive(
                          value: rows[index].enabled,
                          onChanged: (value) => onToggle(rows[index], value),
                          activeThumbColor: Colors.white,
                          activeTrackColor: const Color(0xFFFF6338),
                          inactiveTrackColor: const Color(0xFFF1EEEC),
                          inactiveThumbColor: Colors.white,
                        ),
                ),
              ),
              if (index < rows.length - 1)
                const Divider(height: 1, color: Color(0xFFF0F1F3)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEE8),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFFFF6338),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Keep your account secure with a new password.',
                        style: TextStyle(color: Color(0xFF858A99)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _passwordField(
              _currentController,
              'Current password',
              visible: _showCurrent,
              onToggleVisibility: () =>
                  setState(() => _showCurrent = !_showCurrent),
            ),
            _passwordField(
              _newController,
              'New password',
              visible: _showNew,
              onToggleVisibility: () => setState(() => _showNew = !_showNew),
              validator: (value) => value == null || value.length < 6
                  ? 'Use at least 6 characters'
                  : null,
            ),
            _passwordField(
              _confirmController,
              'Confirm new password',
              visible: _showConfirm,
              onToggleVisibility: () =>
                  setState(() => _showConfirm = !_showConfirm),
              validator: (value) => value != _newController.text
                  ? 'Passwords do not match'
                  : null,
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                Navigator.pop(context, {
                  'currentPassword': _currentController.text,
                  'newPassword': _newController.text,
                });
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: const Color(0xFFFF6338),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Update password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordField(
    TextEditingController controller,
    String label, {
    required bool visible,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: !visible,
        validator:
            validator ??
            (value) => value == null || value.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF3EEEB),
          prefixIcon: const Icon(Icons.key_outlined, size: 20),
          suffixIcon: IconButton(
            onPressed: onToggleVisibility,
            tooltip: visible ? 'Hide password' : 'Show password',
            icon: Icon(
              visible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFFF6338)),
          ),
        ),
      ),
    );
  }
}

class _SettingSection {
  const _SettingSection({required this.title, required this.rows});

  final String title;
  final List<_SettingRow> rows;
}

class _SettingRow {
  _SettingRow(
    this.title, {
    this.enabled = false,
    this.value,
    this.showsChevron = false,
  });

  final String title;
  bool enabled;
  final String? value;
  final bool showsChevron;
}
