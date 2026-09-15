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
  if (!kIsWeb) {
    return FileImage(File(photoUrl));
  }
  return null;
}

Widget profileImageWidget(String? photoUrl, {BoxFit fit = BoxFit.cover}) {
  if (isDataImage(photoUrl)) {
    final data = photoUrl!.substring(photoUrl.indexOf(',') + 1);
    return Image.memory(base64Decode(data), fit: fit);
  }
  return Image.file(File(photoUrl!), fit: fit);
}