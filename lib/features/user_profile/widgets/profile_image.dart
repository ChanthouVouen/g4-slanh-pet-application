import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool isDataImage(String? value) => value?.startsWith('data:image') == true;

ImageProvider? profileImageProvider(String? photoUrl) {
  if (photoUrl == null || photoUrl.isEmpty) return null;
  if (isDataImage(photoUrl)) {
    final data = photoUrl.substring(photoUrl.indexOf(',') + 1);
    return MemoryImage(base64Decode(data));
  }
  if (kIsWeb) return null;
  // A locally-saved photo path may no longer exist (cleared app storage,
  // moved device); fall back to the initials avatar instead of crashing.
  final file = File(photoUrl);
  if (!file.existsSync()) return null;
  return FileImage(file);
}

Widget profileImageWidget(String? photoUrl, {BoxFit fit = BoxFit.cover}) {
  if (isDataImage(photoUrl)) {
    final data = photoUrl!.substring(photoUrl.indexOf(',') + 1);
    return Image.memory(base64Decode(data), fit: fit);
  }
  final file = File(photoUrl!);
  if (!file.existsSync()) {
    return const ColoredBox(
      color: Color(0xFFFFE0D3),
      child: Icon(Icons.pets, color: Color(0xFFFF6338), size: 42),
    );
  }
  return Image.file(file, fit: fit);
}
