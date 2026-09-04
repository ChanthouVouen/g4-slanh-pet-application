import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slanh_pet_application/core/widgets/navigation_bar.dart';
import 'models/profile_model.dart';
import 'widgets/edit_profile_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.profile,
    required this.onSave,
    required this.onPhotoSelected,
  });

  final ProfileModel profile;
  final Future<void> Function(
    String name,
    String phone,
    String dateOfBirth,
    String bio,
    String gender,
  ) onSave;
  final Future<void> Function(XFile image) onPhotoSelected;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  // late final TextEditingController _cityController;
  late final TextEditingController _bioController;
  late final TextEditingController _usernameController;
  late final TextEditingController _birthDateController;
  String? _gender;
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _phoneController = TextEditingController(
      text: widget.profile.phone == 'Add your phone number'
          ? ''
          : widget.profile.phone,
    );
    // _cityController = TextEditingController();
    _bioController = TextEditingController();
    _usernameController = TextEditingController(
      text: '@${widget.profile.name.toLowerCase().replaceAll(' ', '')}',
    );
    _birthDateController = TextEditingController(
      text: widget.profile.dateOfBirth ?? '',
    );
    _bioController.text = widget.profile.bio ?? '';
    _gender = widget.profile.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    // _cityController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F4),
        elevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('Save', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            ProfilePhotoEditor(
              profile: widget.profile,
              onPhotoSelected: widget.onPhotoSelected,
            ),
            const SizedBox(height: 26),
            ProfileField(
              label: 'Full Name',
              controller: _nameController,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your name'
                  : null,
            ),
            ProfileField(
              label: 'Username',
              controller: _usernameController,
              readOnly: true,
            ),
            ProfileField(
              label: 'Email',
              initialValue: widget.profile.email,
              readOnly: true,
            ),
            ProfileField(label: 'Phone', controller: _phoneController),
            ProfileGenderField(
              value: _gender,
              onChanged: (value) => setState(() => _gender = value),
            ),
            ProfileField(
              label: 'Date of Birth',
              controller: _birthDateController,
              readOnly: true,
              suffixIcon: Icons.calendar_today_outlined,
              onTap: _selectBirthDate,
            ),
            // ProfileField(label: 'City', controller: _cityController),
            ProfileField(label: 'Bio', controller: _bioController, maxLines: 3),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 4,
        onTap: _ignoreNavigation,
      ),
    );
  }

  static void _ignoreNavigation(int index) {}

  Future<void> _selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime(1995, 6, 15),
    );
    if (date == null || !mounted) return;
    _birthDateController.text =
        '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await widget.onSave(
        _nameController.text,
        _phoneController.text,
        _birthDateController.text,
        _bioController.text,
        _gender ?? '',
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save profile: $error')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
