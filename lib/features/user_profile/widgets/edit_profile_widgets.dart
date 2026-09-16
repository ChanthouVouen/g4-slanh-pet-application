import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slanh_pet_application/core/models/profile/profile.dart';
import 'profile_image.dart';

/// image_picker has no camera backend on desktop (Windows/macOS/Linux) —
/// ImageSource.camera throws a StateError there — so only offer it where
/// it can actually work.
bool get _supportsCameraCapture {
  if (kIsWeb) return true;
  return Platform.isAndroid || Platform.isIOS;
}

class ProfilePhotoEditor extends StatefulWidget {
  const ProfilePhotoEditor({
    super.key,
    required this.profile,
    required this.onPhotoSelected,
  });

  final ProfileModel profile;
  final Future<void> Function(XFile image) onPhotoSelected;

  @override
  State<ProfilePhotoEditor> createState() => _ProfilePhotoEditorState();
}

class _ProfilePhotoEditorState extends State<ProfilePhotoEditor> {
  XFile? _selectedImage;
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 170,
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: _selectedImage != null
                    ? FutureBuilder(
                        future: _selectedImage!.readAsBytes(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : widget.profile.photoUrl?.isNotEmpty == true
                    ? profileImageWidget(widget.profile.photoUrl)
                    : ColoredBox(
                        color: const Color(0xFFFFE0D3),
                        child: Center(
                          child: Text(
                            widget.profile.name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFFFF6338),
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -12,
              child: CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFFFF6338),
                child: IconButton(
                  tooltip: 'Change photo',
                  onPressed: _uploading ? null : () => _pickPhoto(context),
                  color: Colors.white,
                  icon: const Icon(Icons.camera_alt_outlined, size: 20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        TextButton(
          onPressed: _uploading ? null : () => _pickPhoto(context),
          child: Text(
            _uploading ? 'Uploading photo...' : 'Tap to change photo',
          ),
        ),
      ],
    );
  }

  Future<void> _pickPhoto(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            if (_supportsCameraCapture)
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Take a selfie'),
                subtitle: const Text('Use the front camera'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
              ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 6000,
        maxHeight: 6000,
      );
      if (image == null) return;
      setState(() {
        _selectedImage = image;
        _uploading = true;
      });
      await widget.onPhotoSelected(image);
      if (mounted) setState(() => _uploading = false);
    } catch (error) {
      if (mounted) setState(() => _uploading = false);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update profile photo: $error')),
      );
    }
  }
}

class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
    this.suffixIcon,
    this.onTap,
    this.validator,
  });

  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final bool readOnly;
  final int maxLines;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 7),
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF3EEEB),
              suffixIcon: suffixIcon == null
                  ? null
                  : Icon(suffixIcon, size: 17),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 17,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileGenderField extends StatelessWidget {
  const ProfileGenderField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gender', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          const SizedBox(width: 7),
          DropdownButtonFormField<String>(
            initialValue: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Select gender',
              filled: true,
              fillColor: const Color(0xFFF3EEEB),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
          ),
        ],
      ),
    );
  }
}
